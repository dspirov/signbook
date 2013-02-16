#!/usr/bin/perl


package Tk::TeacherEdit;
use base qw/Tk::Teacher/;
use strict;
use warnings;
use utf8;

Construct Tk::Widget 'TeacherEdit';

sub SetTeacher {
	my ($self, $teacher) = @_;
	$self->{'teacher'}=$teacher;
	$self->{'name'}->delete(0, 'end');
	$self->{'name'}->insert('end', $teacher->name);
	$self->configure('-title'=>'Редактиране на учител: '.$teacher->name);
}

sub Submit {
	my ($self) = @_;
	$self->{'teacher'}->name($self->{'name'}->get);
	$self->{'teacher'}->update();
	$self->configure('-title'=>'Редактиране на учител: '.$self->{'teacher'}->name);
}