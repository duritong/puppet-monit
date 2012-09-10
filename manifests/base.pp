# Base class that setups the common things
class monit::base {
  package { 'monit':
    ensure => installed,
  }

  service { 'monit':
    ensure  => running,
    enable  => true,
    require => Package['monit'],
  }

  # How to tell monit to reload its configuration
  exec { 'monit reload':
    command     => '/usr/sbin/monit reload',
    refreshonly => true,
  }

  # Default values for all file resources
  File {
    owner   => 'root',
    group   => 0,
    mode    => '0400',
    notify  => Exec['monit reload'],
    require => Package['monit'],
  }

  # The main configuration directory, this should have been provided by
  # the "monit" package, but we include it just to be sure.
  file {
    '/etc/monit':
      ensure  => directory,
      mode    => '0700';
    # The configuration snippet directory.  Other packages can put
    # *.monitrc files into this directory, and monit will include them.
    '/etc/monit/conf.d':
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      mode    => '0700';
    '/etc/monit/monitrc':
      content => template('monit/monitrc.erb');
  }

  # A template configuration snippet.  It would need to be included,
  # since monit's "include" statement cannot handle an empty directory.
  monit::snippet{ 'monit_template':
    source => 'puppet:///modules/monit/template.monitrc',
  }
}
