#!/usr/bin/perl


package Tk::RoomsAdministration;
use base qw/Tk::Toplevel/;
use strict;
use warnings;
use utf8;

use Tk::RoomAdd;

Construct Tk::Widget 'RoomsAdministration';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}


sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $menu=$self->Frame()->pack(qw/-side top/);
	$menu->Button('-text'=>'добавяне на стая', '-command'=> sub {
			my $dialog=$self->RoomAdd()->SetSchema($self->{'schema'});
		} )->pack(qw/-side left/);
	$menu->Button('-text'=>'обновяване на списъка', '-command'=> sub { $self->{'list'}->Refresh } )->pack(qw/-side left/);
	
	$self->{'list'}=$self->RoomsList()->pack(qw/-side top/);
}

sub SetSchema {
	my ($self, $schema) = @_;
	$self->{'schema'} = $schema;
	$self->{'list'}->SetSchema($schema, 1);
	$self->configure('-title'=>'Администрация на стаите');
}

1;