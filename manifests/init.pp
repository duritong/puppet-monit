# Module: monit
#
# A puppet module to configure the monit service, and add definitions to be
# used from other classes and modules.
#
# Stig Sandbeck Mathisen <ssm@fnord.no>
# Micah Anderson micah@riseup.net
#
# To set any of the following, simply set them as class parameters
# before the class is included, for example:
#
# class{'monit':
#   alert => 'someone@example.org',
#   mailserver => 'mail.example.com'
# }
#
# The following is a list of the currently available parameters:
#
# alert:         Who should get the email notifications?
#                Example: root@localhost
#                Default: Cenots: 'absent', Debian: root@localhost 
#
# mailserver:    Where should monit be sending mail?
#                Set this to your mailserver
#                Monit will disable alert notification if no mailserver is
#                present.
#                Example: 'localhost'
#                Default: CentOS: 'absent', Debian: 'localhost'
#
# enable_httpd:  Should the httpd daemon be enabled?
#                Set this to 'yes' to enable it, be sure
#                you set the secret parameter as well.
#                Valid values: yes or no
#                Default: no
#
# httpd_port:    What port should the httpd run on?
#                Default: 2812
#
# pool_interval: How often (in seconds) should monit poll?
#                Default: 120
#
# secret:        The secret for the httpd daemon. Please read also
#                that parameter's documentation!
#                The default value will fail if required.
#                Default: "This is not very secret, is it?"
#
class monit(
  $secret = 'This is not very secret, is it?',
  $alert = $::operatingsystem ? {
    centos  => 'absent',
    default => 'root@localhost' 
  },
  $mailserver = $::operatingsystem ? {
    centos  => 'absent',
    default => 'localhost' 
  },
  $pool_interval = $::operatingsystem ? {
    centos  => '60',
    default => '120'
  },
  $enable_httpd = 'no',
  $httpd_port = 2812
){
  if $secret == 'This is not very secret, is it?' and $enable_httpd == 'yes' {
    fail('You should set a different secret if you want to use the httpd!')
  }

  $base_config_path = $::operatingsystem ? {
    centos => '/etc/monit.d',
    default => '/etc/monit/conf.d' 
  }

  case $::operatingsystem {
    debian,ubuntu: { include monit::debian }
    centos: { include monit::centos }
    default: { include monit::base }
  }
}
