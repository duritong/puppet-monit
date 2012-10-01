# Debian specific configurations for the
# monit service
class monit::debian inherits monit::base {
  # Monit is disabled by default on debian / ubuntu
  file { '/etc/default/monit':
    content => "startup=1\nCHECK_INTERVALS=${monit::pool_interval}\n",
    notify  => Service['monit']
  }

  # A template configuration snippet.  It needs to be included,
  # since monit's "include" statement cannot handle an empty directory.
  monit::snippet{ 'monit_template':
    source => 'puppet:///modules/monit/template.monitrc',
  }
}
