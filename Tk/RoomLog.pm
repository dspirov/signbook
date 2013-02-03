#!/usr/bin/perl


package Tk::RoomLog;
use base qw/Tk::Table/;
use strict;
use warnings;

Construct Tk::Widget 'RoomLog';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Refresh
{
	my ($self) = @_;
	my $data=$self->{'room'}->search_related('lectures');
	my $row=2;
	$self->clear;
	$self->put(1,1, "Teacher");
	$self->put(1,2, "Start");
	$self->put(1,3, "End");
	while( my $lecture = $data->next )
	{
		$self->put($row, 1, $lecture->teacher->name);
		$self->put($row, 2, $lecture->start);
		$self->put($row, 3, $lecture->end) if($lecture->returned);
		$row++;
	}
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
}

sub SetRoom {
	my ($self, $room) = @_;
	$self->{'room'}=$room;
	$self->Refresh();
}

1;