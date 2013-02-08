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
	my $row=1;
	$self->configure(qw/-fixedrows 1/);
	$self->clear;
	$self->put(0,0, "Teacher");
	$self->put(0,1, "Start");
	$self->put(0,2, "End");
	while( my $lecture = $data->next )
	{
		$self->put($row, 0, $lecture->teacher->name);
		$self->put($row, 1, $lecture->start);
		$self->put($row, 2, $lecture->end) if($lecture->returned);
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