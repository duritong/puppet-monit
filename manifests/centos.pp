# centos specific configuration
class monit::centos inherits monit::base {
  File['/etc/monit/monitrc'] {
    path => '/etc/monit.conf'
  }
  File['/etc/monit/conf.d']{
    path => '/etc/monit.d'
  }

  file{'/etc/monit.d/logging':
    content => '# log to monit.log
set logfile /var/log/monit
',
    owner   => root,
    group   => 0,
    mode    => '0644',
    require => Package['monit'],
    notify  => Service['monit'],
  }
}
