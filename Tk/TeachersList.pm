#!/usr/bin/perl


package Tk::TeachersList;
use base qw/Tk::Table/;
use strict;
use warnings;

Construct Tk::Widget 'TeachersList';

use Tk::TeacherLog;
use Tk::TeacherEdit;

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Refresh {
	my ($self) = @_;
	$self->clear;
	my $teachers=$self->{'schema'}->resultset('Teacher');
	$self->configure(qw/-fixedrows 1/);
	my $row=1;
	$self->put(0,0, "ID");
	$self->put(0,1, "Name");
	while(my $teacher = $teachers->next)
	{
		$self->put($row,0, $teacher->id);
		$self->put($row,1, $teacher->name);
		$self->put($row,2, $self->Button('-text'=>'view log', '-command'=>sub {
				my $logWindow=$self->Toplevel();
				$logWindow->configure('-title'=>'Log for '.$teacher->name);
				$logWindow->TeacherLog()->pack(qw/-side top/)->SetTeacher($teacher);
			}));
		$self->put($row,3, $self->Button('-text'=>'edit', '-command'=>sub {
					$self->TeacherEdit()->SetTeacher($teacher);
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