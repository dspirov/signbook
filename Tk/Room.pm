#!/usr/bin/perl


package Tk::Room;
use base qw/Tk::Toplevel/;
use strict;
use warnings;

Construct Tk::Widget 'Room';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $nameLabel = $self->Label('-text'=>'Name');
	$self->{'name'} = $self->Entry();
	my $capacityLabel = $self->Label('-text'=>'Capacity');
	$self->{'capacity'} = $self->Entry();
	$self->{'submitBtn'} = $self->Button('-text'=>'Save','-command'=>sub { $self->Submit(); });
	
	$nameLabel->grid($self->{'name'});
	$capacityLabel->grid($self->{'capacity'});
	$self->{'submitBtn'}->grid();
}

sub Submit {
	
}