# Using strace, find out why Apache is returning a 500 error.

exec {'modification':
  command => '/bin/sed -i "s/pphp/php/g" /var/www/html/wp-settings.php',
  path    => ['/usr/bin', '/usr/sbin']
}
