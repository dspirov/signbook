#!/usr/bin/perl


package Tk::RoomsList;
use base qw/Tk::Table/;
use strict;
use warnings;

Construct Tk::Widget 'RoomsList';

use Tk::RoomLog;

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Refresh {
	my ($self) = @_;
	$self->clear;
	my $rooms=$self->{'schema'}->resultset('Room');
	my $row=2;
	$self->put(1,1, "ID");
	$self->put(1,2, "Name");
	$self->put(1,3, "Capacity");
	while(my $room = $rooms->next)
	{
		$self->put($row,1, $room->id);
		$self->put($row,2, $room->name());
		$self->put($row,3, $room->capacity());
		$self->put($row,4, $self->Button('-text'=>'view log', '-command'=>sub {
				my $logWindow=$self->Toplevel();
				$logWindow->configure('-title'=>'Log for '.$room->name);
				$logWindow->RoomLog()->pack(qw/-side top/)->SetRoom($room);
			}));
		$self->put($row,5, $self->Button('-text'=>'start lecture', '-command'=>sub {
				my $startWindow=$self->Toplevel();
				$startWindow->configure('-title'=>'Start lecture in '.$room->name);
				my $lecture=$startWindow->LectureStart()->pack(qw/-side top/);
				$lecture->SetSchema($self->{'schema'});
				$lecture->{'room'}->insert('end', $room->name);
			}));
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