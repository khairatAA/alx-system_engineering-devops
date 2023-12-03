#  Install Nginx web server (w/ Puppet)

# Update
exec { 'apt_update':
  command => 'apt-get update',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# Install nginx
package { 'nginx':
  ensure     => 'installed',
}

# Write in index.html
file { '/var/www/html/index.html':
  content => 'Hello World!\n',
}

# Write in error-page.html
file { '/var/www/html/error-page.html':
  content => "Ceci n'est pas une page\n",
}

# redirection & error page
$redirection = "
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
	location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files \$uri \$uri/ =404;
        }

        error_page 404 /error-page.html;
        location /error-page.html {
                root /var/www/html;
                internal;
        }

        location /redirect_me {
                return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
        }

}
"

# Handle redirection and error page
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  path    => '/etc/nginx/sites-enabled/default',
  content => $redirection,
}

# restart nginx
exec { 'service_restart':
  command => 'service nginx restart',
  path    => '/usr/bin:/usr/sbin:/bin',
}

# start nginx
service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
