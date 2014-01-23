use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use FindBin;

use SampleApp::Web::Admin::User;

subtest 'route test /' => sub {
    SampleApp::Web::Admin::User->input();
};

#subtest 'route test /admin/user/thanks' => sub {
#    my $t = Test::Mojo->new('SampleApp::Web');
#    $t->post_ok('/admin/user/thanks')->status_is(200);
#};
#$t->get_ok('/conf')->status_is(200)->content_like(qr/Mojolicious/i);
#$t->get_ok('/conf')->status_is(200)->content_like(qr/Mojolicious/i);
done_testing();
