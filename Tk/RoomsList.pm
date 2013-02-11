#!/usr/bin/perl


package Tk::RoomsList;
use base qw/Tk::Table/;
use strict;
use warnings;

Construct Tk::Widget 'RoomsList';

use Tk::RoomLog;
use Tk::RoomEdit;

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Refresh {
	my ($self) = @_;
	$self->clear;
	my $rooms=$self->{'schema'}->resultset('Room');
	my $row=1;
	$self->configure(qw/-fixedrows 1/);
	$self->put(0,0, "ID");
	$self->put(0,1, "Name");
	$self->put(0,2, "Capacity");
	while(my $room = $rooms->next)
	{
		$self->put($row,0, $room->id);
		$self->put($row,1, $room->name());
		$self->put($row,2, $room->capacity());
		$self->put($row,3, $self->Button('-text'=>'view log', '-command'=>sub {
				my $logWindow=$self->Toplevel();
				$logWindow->configure('-title'=>'Log for '.$room->name);
				$logWindow->RoomLog()->pack(qw/-side top/)->SetRoom($room);
			}));
		$self->put($row,4, $self->Button('-text'=>'start lecture', '-command'=>sub {
				my $startWindow=$self->Toplevel();
				$startWindow->configure('-title'=>'Start lecture in '.$room->name);
				my $lecture=$startWindow->LectureStart()->pack(qw/-side top/);
				$lecture->SetSchema($self->{'schema'});
				$lecture->{'room'}->insert('end', $room->name);
			}));
		$self->put($row,5, $self->Button('-text'=>'edit', '-command'=>sub {
				$self->RoomEdit()->SetRoom($room);
			})) if($self->{'showEdit'});
		$row++;
	}
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
}

sub SetSchema {
	my ($self, $schema, $showEdit) = @_;
	$self->{'schema'} = $schema;
	$self->{'showEdit'} = $showEdit;
	$self->Refresh();
}

1;