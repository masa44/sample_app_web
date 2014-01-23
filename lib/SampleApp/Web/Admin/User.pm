package SampleApp::Web::Admin::User;
use Mojo::Base 'Mojolicious::Controller';
use FormValidator::Lite;
use Data::Dumper;
use SampleApp::DB;
use DDP;

# This action will render a template
sub input {
    my $self = shift;

    my $fill_ref = {};
    $fill_ref->{name1}   = $self->psession->{name1};
    $fill_ref->{name2}   = $self->psession->{name2};
    $fill_ref->{kana1}   = $self->psession->{kana1};
    $fill_ref->{kana2}   = $self->psession->{kana2};
    $fill_ref->{email}   = $self->psession->{email};
    $fill_ref->{sex}     = $self->psession->{sex};
    $fill_ref->{remarks} = $self->psession->{remarks};
    $fill_ref->{group}   = $self->psession->{group};

    $self->render(
        'admin/user/input',
        handler => 'tx',
        fill    => $fill_ref || {},
    );
}

sub conf {
    my $self = shift;

    # error check
    my $validator = FormValidator::Lite->new( $self->req );
    $validator->check(
        'name1'   => ['NOT_NULL'],
        'name2'   => ['NOT_NULL'],
        'kana1'   => ['NOT_NULL'],
        'kana2'   => ['NOT_NULL'],
        'sex'     => ['NOT_NULL'],
        'email'   => ['NOT_NULL'],
        'remarks' => ['NOT_NULL'],
        'group'   => ['NOT_NULL'],
    );

    if ( $validator->has_error ) {

        # output data set
        my $out = {};
        $out->{error} = $validator->errors();

        $self->stash($out);
        $self->render(
            'admin/user/input',
            handler => 'tx',
            fill    => $self->req->params,
        );
    }
    else {
        # session data set
        $self->psession->{name1}   = $self->req->params;
        $self->psession->{name1}   = $self->param('name1');
        $self->psession->{name2}   = $self->param('name2');
        $self->psession->{kana1}   = $self->param('kana1');
        $self->psession->{kana2}   = $self->param('kana2');
        $self->psession->{email}   = $self->param('email');
        $self->psession->{remarks} = $self->param('remarks');
        $self->psession->{sex}     = $self->param('sex');
        $self->psession->{group}   = $self->param('group');

        # output data set
        my $out = {};
        $out->{name1}   = $self->param('name1');
        $out->{name2}   = $self->param('name2');
        $out->{kana1}   = $self->param('kana1');
        $out->{kana2}   = $self->param('kana2');
        $out->{email}   = $self->param('email');
        $out->{remarks} = $self->param('remarks');
        $out->{sex}     = $self->param('sex');
        foreach my $sex ( $self->param('sex') ) {
            $out->{ 'sex_' . $sex } = 1;
        }
        foreach my $group ( $self->param('group') ) {
            $out->{ 'group_' . $group } = 1;
        }
        $self->stash($out);

        $self->render( 'admin/user/conf', handler => 'tx', );
    }
}

sub thanks {
    my $self = shift;

    my $hash_ref = $self->psession->{session_data};

    my $row = $self->app->db->insert(
        'admin_user',
        {
            'name1'      => $self->psession->{'name1'},
            'name2'      => $self->psession->{'name2'},
            'kana1'      => $self->psession->{'kana1'},
            'kana2'      => $self->psession->{'kana2'},
            'email'      => $self->psession->{'email'},
            'sex'        => $self->psession->{'sex'},
            'remarks'    => $self->psession->{'remarks'},
            'group_list' => $self->psession->{'group'},
        }
    );

    $self->render( 'admin/user/thanks', handler => 'tx', );
}

1;
