#!/usr/bin/perl


package Tk::TeachersAdministration;
use base qw/Tk::Toplevel/;
use strict;
use warnings;

use Tk::TeacherAdd;
use Tk::TeachersList;

Construct Tk::Widget 'TeachersAdministration';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}


sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $menu=$self->Frame()->pack(qw/-side top/);
	$menu->Button('-text'=>'Add teacher', '-command'=> sub {
			my $dialog=$self->TeacherAdd()->SetSchema($self->{'schema'});
		} )->pack(qw/-side left/);
	$menu->Button('-text'=>'Refresh list', '-command'=> sub { $self->{'list'}->Refresh } )->pack(qw/-side left/);
	
	$self->{'list'}=$self->TeachersList()->pack(qw/-side top/);
}

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'} = $schema;
	$self->{'list'}->SetSchema($schema);
}

1;