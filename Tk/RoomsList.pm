#!/usr/bin/perl


package Tk::RoomsList;
use base qw/Tk::Table/;
use strict;
use warnings;

Construct Tk::Widget 'RoomsList';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Refresh {
	my ($self) = @_;
	my $rooms=$self->{'schema'}->resultset('Room');
	my $row=1;
	while(my $room = $rooms->next)
	{
		$self->put($row,1, $room->id);
		$self->put($row,2, $room->name());
		$self->put($row,3, $room->capacity());
		$row++;
	}
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
}

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'} = $schema;
	$self->Refresh();
}

1;