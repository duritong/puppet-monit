# Debian specific configurations for the
# monit service
class monit::debian inherits monit::base {
  Service[monit]{
    hasstatus => false,
  }
  # Monit is disabled by default on debian / ubuntu
  file { '/etc/default/monit':
    content => "START=yes\n#MONIT_OPTS=\n",
    notify  => Service['monit']
  }

  # A template configuration snippet.  It needs to be included,
  # since monit's "include" statement cannot handle an empty directory.
  monit::snippet{ 'monit_template':
    source => 'puppet:///modules/monit/template.monitrc',
  }
}
