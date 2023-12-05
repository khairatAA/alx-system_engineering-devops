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

# custom header
$custom_header = "
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
		add_header X-Served-By \$hostname;
        }
}
"

# Handle custom_header
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  path    => '/etc/nginx/sites-enabled/default',
  content => $custom_header,
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
