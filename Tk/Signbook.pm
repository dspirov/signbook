#!/usr/bin/perl


package Tk::Signbook;
use base qw/Tk::MainWindow/;
use strict;
use warnings;

use Tk::LectureStart;
use Tk::LectureEnd;
use Tk::RoomsList;
use Tk::TeachersAdministration;
use Tk::RoomsAdministration;

Construct Tk::Widget 'Signbook';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub openLectureStart {
	my $self = shift;
	my $w=$self->Toplevel('-title'=>'Start Lecture');
	my $lectureDialog=$w->LectureStart()->pack(qw/-side top/);
	$lectureDialog->SetOnSubmit(sub { $w->destroy(); });
	$lectureDialog->SetSchema($self->{'schema'});
}

sub openLectureEnd {
	my $self = shift;
	my $w=$self->Toplevel('-title'=>'End Lecture');
	my $lectureDialog=$w->LectureEnd()->pack(qw/-side top/);
	$lectureDialog->SetOnSubmit(sub { $w->destroy(); });
	$lectureDialog->SetSchema($self->{'schema'});
}

sub openTeachersDialog {
	my $self = shift;
	$self->TeachersAdministration()->SetSchema($self->{'schema'});
}

sub openRoomsDialog {
	my $self = shift;
	$self->RoomsAdministration()->SetSchema($self->{'schema'});
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $userMenu=$self->Frame()->pack(qw/-side top/);
	my $lectureStartBtn=$userMenu->Button( '-text'=>'Start', '-command'=>sub { $self->openLectureStart; } )
						->pack(qw/-side left/);
	my $lectureEndBtn=$userMenu->Button( '-text'=>'End', '-command'=>sub { $self->openLectureEnd } )
						->pack(qw/-side left/);
	
	my $adminMenu=$self->Frame()->pack(qw/-side top/);
	my $teachersAdminBtn=$adminMenu->Button( '-text'=>'Edit Teachers', '-command'=>sub { $self->openTeachersDialog } )
						->pack(qw/-side left/);
	my $roomsAdminBtn=$adminMenu->Button( '-text'=>'Edit Rooms', '-command'=>sub { $self->openRoomsDialog } )
						->pack(qw/-side left/);
	
	$self->{'roomsList'}=$self->RoomsList()->pack(qw/-side top/);
}

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'} = $schema;
	$self->{'roomsList'}->SetSchema($schema);
}

1;