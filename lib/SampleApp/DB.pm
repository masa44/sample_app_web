package SampleApp::DB;

use parent 'Teng';
use Mouse;
use Plack::Util;
use SampleApp::DB;

has 'instances' => (
    traits  => ['Hash'],
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { +{} },
    handles => {
        set_instance => 'set'
    }
);

sub init {
    my ( $class, $config ) = @_;

    my $teng = SampleApp::DB->new(
        {
            connect_info => [
"DBI:mysql:database=$config->{database};host=$config->{hostname};",
                $config->{user},
                $config->{password},
                { mysql_enable_utf8 => 1 }
            ]
        }
    );

    return $teng;
}

sub load {
    my ( $self, $name ) = @_;
    my $instance = $self->instances->{$name};
    return $instance if $instance;
    my $class = Plack::Util::load_class( $name, 'SampleApp::DB' );
    $instance = $class->new;
    $self->set_instance( $name, $instance );
    return $instance;
}

1;
