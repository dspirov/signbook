#!/usr/bin/perl


package Tk::Lecture;
use base qw/Tk::Frame/;
use strict;
use warnings;
use Tk::Table;

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
	my $table=$self->Table(qw/-rows 5 -columns 2 -scrollbars 0/)->pack(qw/-side top/);
	
	my $teacherLabel=$table->Label(qw/-text teacher/);
	my $teacher=$table->Entry();
	my $roomLabel=$table->Label(qw/-text room/);
	my $room=$table->Entry();
	my $saveBtn=$table->Button('-text'=>'Save', '-command'=> sub { $self->submit(); });
	$self->{'status'}='';
	my $statusLabel=$table->Label('-textvariable'=>\$self->{'status'});
	
	$table->put(1,1, $teacherLabel);
	$table->put(1,2, $teacher);
	$table->put(2,1, $roomLabel);
	$table->put(2,2, $room);
	$table->put(3,1, $saveBtn);
	$table->put(3,2, $statusLabel);
	
	$self->{'teacher'}=$teacher;
	$self->{'room'}=$room;
}

1;