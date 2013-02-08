#!/usr/bin/perl


package Tk::Teacher;
use base qw/Tk::Toplevel/;
use strict;
use warnings;

Construct Tk::Widget 'Teacher';

sub ClassInit {
	my ($class, $mw) = @_;
	$class->SUPER::ClassInit($mw);
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	my $nameLabel = $self->Label('-text'=>'Name')->pack(qw/-side top/);
	$self->{'name'} = $self->Entry()->pack(qw/-side top/);
	$self->{'submitBtn'} = $self->Button('-text'=>'Save','-command'=>sub { $self->Submit(); })
			->pack(qw/-side top/);
}

sub Submit {
	
}