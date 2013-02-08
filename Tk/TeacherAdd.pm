#!/usr/bin/perl


package Tk::TeacherAdd;
use base qw/Tk::Teacher/;
use strict;
use warnings;

Construct Tk::Widget 'TeacherAdd';

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'} = $schema;
	$self->configure('-title'=>'Add teacher');
}

sub Submit {
	my ($self) = @_;
	$self->{'schema'}->resultset('Teacher')->create({ 'name'=>$self->{'name'}->get });
	$self->destroy();
}