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
    "${monit::base_config_path}/${name}.monitrc":
      ensure => $ensure,
      owner  => 'root',
      group  => 0,
      mode   => '0400',
      notify => Service['monit'],
  }
  if $content {
    File["${monit::base_config_path}/${name}.monitrc"]{
      content => $content
    }
  }
  if $target {
    File["${monit::base_config_path}/${name}.monitrc"]{
      target => $target
    }
  }
  if $source {
    File["${monit::base_config_path}/${name}.monitrc"]{
      source => $source
    }
  }
}
