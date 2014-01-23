use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

subtest 'route test /' => sub {
    my $t = Test::Mojo->new('SampleApp::Web');
    $t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);
};


subtest 'route test /admin/user/input' => sub {
    my $t = Test::Mojo->new('SampleApp::Web');
    $t->get_ok('/admin/user/input')->status_is(200);
};

subtest 'route test /admin/user/conf' => sub {
    my $t = Test::Mojo->new('SampleApp::Web');
    $t->post_ok('/admin/user/conf')->status_is(200);
};

#subtest 'route test /admin/user/thanks' => sub {
#    my $t = Test::Mojo->new('SampleApp::Web');
#    $t->post_ok('/admin/user/thanks')->status_is(200);
#};
#$t->get_ok('/conf')->status_is(200)->content_like(qr/Mojolicious/i);
#$t->get_ok('/conf')->status_is(200)->content_like(qr/Mojolicious/i);
done_testing();
