#!/usr/bin/perl


package Tk::Room;
use base qw/Tk::Toplevel/;
use strict;
use warnings;
use utf8;

Construct Tk::Widget 'Room';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $nameLabel = $self->Label('-text'=>'име');
	$self->{'name'} = $self->Entry();
	my $capacityLabel = $self->Label('-text'=>'капацитет');
	$self->{'capacity'} = $self->Entry();
	$self->{'submitBtn'} = $self->Button('-text'=>'запази','-command'=>sub { $self->Submit(); });
	
	$nameLabel->grid($self->{'name'});
	$capacityLabel->grid($self->{'capacity'});
	$self->{'submitBtn'}->grid();
}

sub Submit {
	
}