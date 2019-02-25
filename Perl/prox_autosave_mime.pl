#!/usr/bin/env perl
use strict;
use warnings;
use HTTP::Proxy;
use HTTP::Proxy::BodyFilter::save;
use Digest::MD5 qw( md5_hex );
use POSIX qw( strftime );

my $proxy = HTTP::Proxy->new("port" => 3128);

# un filtre pour sauver les fichiers FLV
my $flv_filter = HTTP::Proxy::BodyFilter::save->new(
    filename => sub {
        my ($message) = @_;
        my $uri = $message->request->uri;
        # trouve l'id dans l'URL ou sinon calcule un hash MD5
        my ($id) = $uri->query =~ /id=([^&;]+)/i;
        $id = md5_hex($uri) unless $id;
        # construit le nom de fichier en ajoutant le nom du site
        my ($host) = $uri->host =~ /([^.]+\.[^.]+)$/;
        my $file = strftime "flv/%Y-%m-%d/${host}_$id.flv", localtime;
        # ignore le fichier si on l'a déjà
        return if -e $file && -s $file == $message->content_length;
        # renvoie le nom du fichier à sauver
        return $file;
    }
);

# ajoute le filtre sur tous les types MIME qu'on veut sauver
for my $mime (qw( video/flv video/x-flv )) {
    $proxy->push_filter(
        mime     => $mime,
        response => $flv_filter,
    );
}

# démarre le proxy
$proxy->start;


