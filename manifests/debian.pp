class monit::debian inherits monit::base {
	# Monit is disabled by default on debian / ubuntu
	file { "/etc/default/monit":
    content => "startup=1\nCHECK_INTERVALS=${monit::pool_interval}\n",
		before  => Service["monit"]
	}
}
