package SampleApp::DB;

use parent 'Teng';
use Mouse;
use Plack::Util;
use SampleApp::DB;

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

1;
