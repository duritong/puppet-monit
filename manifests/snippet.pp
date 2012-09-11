# Define: monit::snippet
# Creates a monit configuration snippet in /etc/monit/conf.d/
#
# Parameters:
#   namevar - the name of this resource will be used for the
#             configuration file name
#   ensure  - present or absent
#   content - as for the "file" type
#   source  - as for the "file" type
#   target  - as for the "file' type
#
# Notifies:
#   Service['monit']
#
define monit::snippet(
  $ensure  = present,
  $target  = undef,
  $source  = undef,
  $content = undef
){
  file {
    "/etc/monit/conf.d/${name}.monitrc":
      ensure => $ensure,
      owner  => 'root',
      group  => 0,
      mode   => '0400',
      notify => Service['monit'],
  }
  if $content {
    File["/etc/monit/conf.d/${name}.monitrc"]{
      content => $content
    }
  }
  if $target {
    File["/etc/monit/conf.d/${name}.monitrc"]{
      target => $target
    }
  }
  if $source {
    File["/etc/monit/conf.d/${name}.monitrc"]{
      source => $source
    }
  }
}
