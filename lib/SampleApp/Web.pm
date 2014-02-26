package SampleApp::Web;
use Mojo::Base 'Mojolicious';
use HTML::FillInForm::Lite qw(fillinform);
use Text::Xslate qw(html_builder);
use SampleApp::Model;
use SampleApp::DB;
use DDP;

# This method will run once at server start
sub startup {
    my $self = shift;

    # hook
    $self->hook(
        after_dispatch => sub {
            my $c = shift;
            if ( $c->res->code =~ /500/ ) {
                $c->render( text => '500 error hooked!!' );
            }
        }
    );

    # plugin setup
    $self->plugin(
        # Xslate plugin
        'xslate_renderer' => {
            template_options => {
                syntax    => 'TTerse',
                tag_start => '<!-- TMPL',
                tag_end   => '-->',
                function  => { fillinform => html_builder( \&fillinform ) },
                module    => ['Text::Xslate::Bridge::Star'],
            }
        }
    );

    # connection pool
    $self->attr(
        db => sub {
            SampleApp::DB->init(
                {
                    hostname => 'localhost',
                    database => 'c0039999',
                    user     => 'c0039999',
                    password => 'c0039999p',
                }
            );
        }
    );

    $self->helper(

        # plack session simple helper
        psession => sub {
            my $self = shift;
            my $env  = $self->req->env;
            return $env->{'psgix.session'};
        },

#        # model呼び出しhelper
#        model => sub {
#            my ( $self, $name ) = @_;
#            SampleApp::Model->new->load($name);
#        },
    );

    $self->helper(
        # model呼び出しhelper
        model => sub {
            my ( $self, $name ) = @_;
            SampleApp::Model->new->load($name);
        }
    );

    # controller name
    my $ctrl = undef;

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->route('/')->to('example#welcome');

    $ctrl = 'admin-user';

    $r->route('/admin/user/input')->to( $ctrl . '#input' );
    $r->route('/admin/user/conf')->to( $ctrl . '#conf' );
    $r->route('/admin/user/thanks')->to( $ctrl . '#thanks' );
}

1;
