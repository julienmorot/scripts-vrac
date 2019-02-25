#!/usr/bin/env perl

use strict;

use Net::IMAP::Simple;
use MIME::Parser;

my $server = "";
my $user = "";
my $pass = "";

my $imap = new Net::IMAP::Simple( $server );
$imap->login($user, $pass);

my $nbmsg = $imap->select( 'INBOX' );

foreach my $msg ( 1..$nbmsg ) {
    my $lines = $imap->get( $msg );
    my $fh = $imap->getfh( $msg );
    my $parser = new MIME::Parser;
    $parser->output_under("/tmp");
    my $entity = $parser->parse($fh);
    close $fh;
}
$imap->quit();

