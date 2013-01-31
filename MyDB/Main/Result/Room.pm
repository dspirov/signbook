package MyDB::Main::Result::Room;
use strict;
use warnings;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('rooms');
__PACKAGE__->add_columns('id', 'name', 'capacity');
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many('lectures', 'MyDB::Main::Result::Lecture', 'room_id');

1;