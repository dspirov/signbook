package MyDB::Main::Result::Lecture;
use strict;
use warnings;
use base qw/DBIx::Class::Core/;

  __PACKAGE__->load_components(qw/InflateColumn::DateTime/);
__PACKAGE__->table('lectures');
__PACKAGE__->add_columns('id', 'room_id', 'teacher_id', 'start', 'end', 'returned');
__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to('teacher', 'MyDB::Main::Result::Teacher', 'teacher_id');
__PACKAGE__->belongs_to('room', 'MyDB::Main::Result::Room', 'room_id');

1;