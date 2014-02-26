package SampleApp::DB::AdminUser;

use Mouse;
use Try::Tiny;
use Carp 'croak';

has 'teng' => (
    is  => 'rw',
    isa => 'Object',
);

sub insert {
    my ( $self, $data ) = @_;

    try {
        $self->teng->insert(
            'admin_user',
            {
                'name1'      => $data->{'name1'},
                'name2'      => $data->{'name2'},
                'kana1'      => $data->{'kana1'},
                'kana2'      => $data->{'kana2'},
                'email'      => $data->{'email'},
                'sex'        => $data->{'sex'},
                'remarks'    => $data->{'remarks'},
                'group_list' => $data->{'group'},
            }
        );
    }
    catch {
        # 個別の例外処理
        croak "caught error: $_";
    };
}

1;
