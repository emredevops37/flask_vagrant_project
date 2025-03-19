#!/bin/bash

# Update ve upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Gerekli paketleri yükleyelim
sudo apt-get install -y python3 python3-pip python3-venv nginx

# Python sanal ortamını home dizininde oluştur (diğer türlü VirtualBox shared folders sorun çıkardı)
cd /home/vagrant
python3 -m venv venv
source /home/vagrant/venv/bin/activate

# Gerekli paketleri yükleme
cd /vagrant
pip install -r requirements.txt

# Nginx yapılandırması
sudo bash -c 'cat > /etc/nginx/sites-available/flask-app << EOF
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF'

# Nginx sitesini etkinleştir
sudo ln -sf /etc/nginx/sites-available/flask-app /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

# Flask uygulamasını otomatik olarak başlat
sudo bash -c 'cat > /etc/systemd/system/flask-app.service << EOF
[Unit]
Description=Gunicorn instance to serve Flask app
After=network.target

[Service]
User=vagrant
Group=www-data
WorkingDirectory=/vagrant
ExecStart=/bin/bash -c "cd /vagrant && source /home/vagrant/venv/bin/activate && gunicorn --reload --workers 3 --bind 0.0.0.0:5000 app:app"

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl start flask-app
sudo systemctl enable flask-app

chmod +x /vagrant/start_dev.sh

echo "Flask uygulaması kurulumu tamamlandı!"
echo "http://localhost:5000/ ve http://localhost:8080/ 'den sayfayı görebilirsiniz :)"