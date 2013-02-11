#!/usr/bin/perl


package Tk::RoomEdit;
use base qw/Tk::Room/;
use strict;
use warnings;

Construct Tk::Widget 'RoomEdit';

sub SetRoom {
	my ($self, $room) = @_;
	$self->{'room'}=$room;
	
	$self->{'name'}->delete(0, 'end');
	$self->{'name'}->insert('end', $room->name);
	$self->{'capacity'}->delete(0, 'end');
	$self->{'capacity'}->insert('end', $room->capacity);
	
	$self->configure('-title'=>'Edit room: '.$room->name);
}

sub Submit {
	my ($self) = @_;
	$self->{'room'}->name($self->{'name'}->get);
	$self->{'room'}->capacity($self->{'capacity'}->get);
	$self->{'room'}->update();
	$self->configure('-title'=>'Edit room: '.$self->{'room'}->name);
}