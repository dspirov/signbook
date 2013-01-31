#!/usr/bin/perl


package Tk::Signbook;
use base qw/Tk::MainWindow/;
use strict;
use warnings;

use Tk::LectureStart;
use Tk::LectureEnd;
use Tk::RoomsList;

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

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $menu=$self->Frame()->pack(qw/-side top/);
	my $lectureStartBtn=$menu->Button( '-text'=>'Start', '-command'=>sub { $self->openLectureStart; } )
						->pack(qw/-side left/);
	my $lectureEndBtn=$menu->Button( '-text'=>'End', '-command'=>sub { $self->openLectureEnd } )
						->pack(qw/-side left/);
	
	$self->{'roomsList'}=$self->RoomsList()->pack(qw/-side top/);
}

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'} = $schema;
	$self->{'roomsList'}->SetSchema($schema);
}

1;