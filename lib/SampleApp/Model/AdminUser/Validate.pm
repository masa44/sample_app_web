package SampleApp::Model::AdminUser::Validate {
    use Mouse;
    use FormValidator::Lite;
    use DDP;

    has 'rule' => (
        is      => 'rw',
        isa     => 'HashRef',
        default => sub {
            {
                'name1'   => ['NOT_NULL'],
                'name2'   => ['NOT_NULL'],
                'kana1'   => ['NOT_NULL'],
                'kana2'   => ['NOT_NULL'],
                'sex'     => ['NOT_NULL'],
                'email'   => ['NOT_NULL'],
                'remarks' => ['NOT_NULL'],
                'group'   => ['NOT_NULL'],
            };
        }
    );

    sub validate {
        my ( $self, $req ) = @_;

        # error check
        my $validator = FormValidator::Lite->new( $req );
        $validator->check( %{ $self->rule() } );

        return $validator;
    }
}

1;
