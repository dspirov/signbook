#!/usr/bin/perl


package Tk::Lecture;
use base qw/Tk::Frame/;
use strict;
use warnings;

Construct Tk::Widget 'Lecture';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'}=$schema;
}

sub SetOnSubmit {
	my ($self, $call) = @_;
	$self->{'onSubmitCall'} = $call;
}

sub submit {
	# defined in inheriting classes
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $teacherLabel=$self->Label(qw/-text teacher/);
	my $teacher=$self->Entry();
	my $roomLabel=$self->Label(qw/-text room/);
	my $room=$self->Entry();
	my $saveBtn=$self->Button('-text'=>'Save', '-command'=> sub { $self->submit(); });
	$self->{'status'}='';
	my $statusLabel=$self->Label('-textvariable'=>\$self->{'status'});
	
	# Arrange widgets in table. See Tk::grid docs.
	$teacherLabel->grid($teacher);
	$roomLabel->grid($room);
	$saveBtn->grid($statusLabel);
	
	$self->{'teacher'}=$teacher;
	$self->{'room'}=$room;
}

1;