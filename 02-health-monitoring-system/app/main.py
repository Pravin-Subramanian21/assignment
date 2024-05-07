import os
from dotenv import load_dotenv
import requests
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

load_dotenv()

def send_email(subject, body):
    sender_email = os.getenv("SENDER_EMAIL")
    receiver_email = os.getenv("RECEIVER_EMAIL")
    password = os.getenv("EMAIL_PASSWORD")

    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    with smtplib.SMTP(os.getenv("SMTP_HOST"), os.getenv("SMTP_PORT")) as server:
        server.starttls()
        server.login(sender_email, password)
        server.sendmail(sender_email, receiver_email, message.as_string())

def check_health(endpoint, config):
    try:
        response = requests.get(endpoint + config["api_path"], timeout=int(os.getenv("TIMEOUT", 5)))
        if response.status_code == int(os.getenv("EXPECTED_STATUS", 200)):
            print(f"Health check API is returning success for {endpoint}{config['api_path']}")
            return True
        else:
            return False
    except Exception as e:
        print("Error ocurred during health check API:", e)
        return False

def main():
    endpoint = os.getenv("ENDPOINT")
    config = {
        "expected_status": int(os.getenv("EXPECTED_STATUS", 200)),
        "timeout": int(os.getenv("TIMEOUT", 5)),
        "api_path": os.getenv("API_PATH", "/health") 
    }

    if not check_health(endpoint, config):
        print(f"Alert: {endpoint}{config['api_path']} is not healthy!")
        send_email("API Endpoint Down", f"The endpoint {endpoint}{config['api_path']} is not responding.")

if __name__ == "__main__":
    main()