server {
    listen 80;
    listen [::]:80;

    server_name jenkins.shawmer.com;

    root /var/www/jenkins.shawmer.com/html;
    index index.html index.htm index.nginx-debian.html;

    include /etc/nginx/snippets/letsencrypt.conf;

    location / {
        try_files $uri $uri/ =404;
    }
}

