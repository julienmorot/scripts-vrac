#!/usr/bin/env perl
use strict;
use warnings;
use Nagios::Plugin::WWW:Mechanize;

my $plugin = Nagios::Plugin::WWW:Mechanize->new(
	usage => "Usage: %s [-U <url>] [-u <user>] [-p <password]"
);

$plugin->add_arg(
	spec => "url|U=s',
	help => "--url URL\n url",
	required => 1
);

$plugin->add_arg(
	spec => "user|u=s',
	help => "--user NAME\n user",
	required => 1
);

$plugin->add_arg(
	spec => "password|p=s',
	help => "--password NAME\n password",
	required => 1
);

$plugin->getopts();

my $opts = $plugin->opts();

$plugin->get($opts->get('url));

$plugin->submit_form(
	form_name => "logonForm",
	fields => {
		username => $opts->get('user'),
		password => $opts->get('password'),
	}
);

my $title = $plugin->mech()->title();
if ($title eq 'Outlook Web App') {
	$plugin->nagios_exit(OK, "OK");
} else {
	$plugin->nagios_exit(CRITICAL, "Cannot log in");
}


        }
