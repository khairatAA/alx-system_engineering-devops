#  Install Nginx web server (w/ Puppet)

exec { 'apt_update':
  command  => 'apt update',
}

package { 'nginx':
  ensure   => installed,
  provider => 'apt',
  require  => Exec['apt_update'],
}

$file_path = '/etc/nginx/sites-available/default'

$file_content = file($file_path)

$replace_content = chomp($file_content).gsub(/listen [::]:80 default_server;/, 'listen 80;')

file { $file_path:
  ensure  => file,
  content => $replace_content,
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

$redirection = "server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;
	server_name _;

	location /redirect_me {
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
	}
}"

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => $redirection,
}

exce { 'nginx_restart':
  command => 'service nginx restart',
  require => [File[$file_path], File['/var/www/html/index.html'], File['/etc/nginx/sites-available/default']],
}
