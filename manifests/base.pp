# Base class that setups the basic monit service
class monit::base {
  package { 'monit':
    ensure => installed,
  }

  service { 'monit':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  # Default values for all the following
  # file resources
  File {
    owner   => 'root',
    group   => 0,
    mode    => '0400',
    notify  => Service['monit'],
    require => Package['monit'],
  }

  file {
    # The configuration snippet directory.  Other packages can put
    # *.monitrc files into this directory, and monit will include them.
    '/etc/monit/conf.d':
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      mode    => '0700';
    '/etc/monit/monitrc':
      content => template("monit/monitrc.${::operatingsystem}.erb");
  }
}
