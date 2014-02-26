package SampleApp::Web::Admin::User;
use Mojo::Base 'Mojolicious::Controller';
use FormValidator::Lite;
use Data::Dumper;
use DDP;

use SampleApp::DB::AdminUser;
use SampleApp::Model::AdminUser::Validate;

my $session_name = 'AdminUser';

sub input {
    my $self = shift;

    my $fill_ref = $self->model('AdminUser::Folder')
      ->input_folder( $self->psession->{$session_name} );

    $self->render(
        'admin/user/input',
        handler => 'tx',
        fill    => $fill_ref,
    );
}

sub conf {
    my $self = shift;

    # validation
    my $result = $self->model('AdminUser::Validate')->validate( $self->req );

    # exist Error
    if ( $result->has_error ) {
        $self->stash( { error => $result->errors } );
        $self->render(
            'admin/user/input',
            handler => 'tx',
            fill    => $self->req->params,
        );
    }
    else {

        # session data set
        $self->psession->{$session_name} = {
            'name1'   => $self->param('name1'),
            'name2'   => $self->param('name2'),
            'kana1'   => $self->param('kana1'),
            'kana2'   => $self->param('kana2'),
            'email'   => $self->param('email'),
            'remarks' => $self->param('remarks'),
            'sex'     => $self->param('sex'),
        };

        #p $psession;

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

    # dn insert by Teng
    my $db_adminuser_obj =
      SampleApp::DB::AdminUser->new( teng => $self->app->db );
    $db_adminuser_obj->insert( $self->psession );

    $self->render( 'admin/user/thanks', handler => 'tx', );
}

1;
