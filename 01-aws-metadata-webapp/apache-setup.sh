#!/bin/bash


sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd

sudo systemctl enable httpd


instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
mac_address=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
ip_address=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)


html_content=$(cat <<EOF
<html>
<head>
<title>AWS Server Metadata Information</title>
<style>
body {
    text-align: center;
}
p b {
    font-weight: bold;
}
</style>
</head>
<body>
<h3>AWS Server Metadata Information</h3>
<p><b>Instance ID:</b> $instance_id<br>
<b>MAC Address:</b> $mac_address<br>
<b>IP Address:</b> $ip_address<br></p>
</body>
</html>
EOF
)

echo "$html_content" | sudo tee /var/www/html/index.html