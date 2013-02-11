#!/usr/bin/perl


package Tk::RoomAdd;
use base qw/Tk::Room/;
use strict;
use warnings;

Construct Tk::Widget 'RoomAdd';

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'} = $schema;
	$self->configure('-title'=>'Add room');
}

sub Submit {
	my ($self) = @_;
	$self->{'schema'}->resultset('Room')->create({
			'name'=>$self->{'name'}->get,
			'capacity'=>$self->{'capacity'}->get
		});
	$self->destroy();
}