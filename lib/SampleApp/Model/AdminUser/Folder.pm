package SampleApp::Model::AdminUser::Folder {
    use Mouse;
    use DDP;

    sub input_folder {
        my ( $self, $indata ) = @_;
        my $folder = {};

        $folder->{name1}   = $indata->{name1};
        $folder->{name2}   = $indata->{name2};
        $folder->{kana1}   = $indata->{kana1};
        $folder->{kana2}   = $indata->{kana2};
        $folder->{email}   = $indata->{email};
        $folder->{sex}     = $indata->{sex};
        $folder->{remarks} = $indata->{remarks};
        $folder->{group}   = $indata->{group};

        return $folder;
    }

    sub confirm_folder {
        my ( $self, $indata ) = @_;
        my $folder = {};

        $folder->{name1}                     = $indata->{name1};
        $folder->{name2}                     = $indata->{name2};
        $folder->{kana1}                     = $indata->{kana1};
        $folder->{kana2}                     = $indata->{kana2};
        $folder->{email}                     = $indata->{email};
        $folder->{sex}                       = $indata->{sex};
        $folder->{ 'sex_' . $indata->{sex} } = 1;
        $folder->{remarks}                   = $indata->{remarks};
        foreach my $group ( @{$indata->{group}} ){
            $folder->{ 'group_' . $group } = 1;
        }

        return $folder;
    }
}

1;
