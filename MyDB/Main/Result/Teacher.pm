package MyDB::Main::Result::Teacher;
use strict;
use warnings;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('teachers');
__PACKAGE__->add_columns('id', 'name');
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many('lectures', 'MyDB::Main::Result::Lecture', 'teacher_id');

1;