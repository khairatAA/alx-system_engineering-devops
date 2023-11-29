#  Install Nginx web server (w/ Puppet)

exec { 'apt_update':
  command  => '/usr/bin/apt update',
}

exec { 'nginx_install':
  command => '/usr/bin/apt install nginx -y',
  require => Exec['apt_update'],
}

#$file_path = '/etc/nginx/sites-available/default'

#$file_content = file($file_path)

# $replace_content = $file_content.strip.gsub(/listen [::]:80 default_server;/, 'listen 80;')

#file { $file_path:
#  ensure  => file,
#  content => $replace_content,
#}

file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Exec['nginx_install']
}

$redirection = "
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;

        location / {
                try_files $${uri} $${uri}/ =404;
        }

        location /redirect_me {
                return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
        }

}
"

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => $redirection,
}

exec { 'service_restart':
  command => '/usr/sbin/service nginx restart',
  require => File['/etc/nginx/sites-available/default'],
}
