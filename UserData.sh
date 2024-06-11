#!/bin/bash

# Update package list
sudo apt-get update -y

# Install Caddy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo tee /usr/share/keyrings/caddy-stable-archive.key
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt-get update -y
sudo apt-get install -y caddy

# Create a Caddyfile configuration for Jenkins
cat <<EOL | sudo tee /etc/caddy/Caddyfile
jenkins.talentofpainting.info {
    reverse_proxy localhost:8080

    tls {
        on_demand
    }

    @http {
        protocol http
    }

    @https {
        protocol https
    }

    handle @http {
        redir https://{host}{uri}
    }

    handle @https {
        reverse_proxy localhost:8080 {
            header_up Host {host}
            header_up X-Real-IP {remote}
            header_up X-Forwarded-For {remote}
            header_up X-Forwarded-Proto {scheme}
        }
    }
}
EOL

# Restart Caddy to apply the new configuration
sudo systemctl restart caddy

# Install Certbot
# sudo apt-get install -y certbot

# Obtain SSL certificate from Let's Encrypt using Certbot for the initial setup
# sudo certbot certonly --webroot -w /var/www/html -d jenkins.talentofpainting.info --non-interactive --agree-tos -m madhura.kurhadkar@gmail.com

# Caddy will automatically use the obtained Let's Encrypt certificates
