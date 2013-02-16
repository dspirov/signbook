#!/usr/bin/perl


package Tk::Lecture;
use base qw/Tk::Frame/;
use strict;
use warnings;
use utf8;

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
	
	my $teacherLabel=$self->Label('-text'=>'учител');
	my $teacher=$self->Entry();
	my $roomLabel=$self->Label('-text'=>'стая');
	my $room=$self->Entry();
	my $saveBtn=$self->Button('-text'=>'запази', '-command'=> sub { $self->submit(); });
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