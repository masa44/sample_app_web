package SampleApp::Model;

use Mouse;
use Plack::Util;

has 'instances' => (
    traits  => ['Hash'],
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { +{} },
    handles => {
        set_instance => 'set'
    }
);

sub load {
    my ( $self, $name ) = @_;
    my $instance = $self->instances->{$name};
    return $instance if $instance;
    my $class = Plack::Util::load_class( $name, 'SampleApp::Model' );
    $instance = $class->new;
    $self->set_instance( $name, $instance );
    return $instance;
}

1;
