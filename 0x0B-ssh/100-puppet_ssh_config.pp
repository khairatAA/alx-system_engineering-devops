# Client configuration file (w/ Puppet)

file { "/etc/ssh/ssh_config":
  ensure  => file,
  content => "IdentityFile ~/.ssh/school\nPasswordAuthentication no\n",
  mode    => '0600'
}
