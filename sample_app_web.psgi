use strict;
use FindBin;
use lib "$FindBin::Bin/lib";
use Mojo::Server::PSGI;
use Plack::Builder;
use SampleApp::Web;
use Cache::Memory::Simple;

my $psgi = Mojo::Server::PSGI->new( app => SampleApp::Web->new );

my $cache = Cache::Memory::Simple->new;

builder {
    enable "Runtime";

    enable 'Session::Simple',
      store       => $cache,
      cookie_name => 'sample_app_web_session';

    $psgi->to_psgi_app;
};
