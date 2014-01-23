package SampleApp::DB::Schema;

use Teng::Schema::Declare;

table{
    name 'admin_user';
    pk 'user_id',
    columns qw( user_id name1 name2 kana1 kana2 sex email group_list remarks );
};

1;
