#!/usr/bin/perl


package Tk::LectureStart;
use base qw/Tk::Lecture/;
use strict;
use warnings;
use POSIX qw/strftime/;
use utf8;

Construct Tk::Widget 'LectureStart';

sub submit {
	my ($self) = @_;
	my $teacher=$self->{'schema'}->resultset('Teacher')
		->find({ 'name'=>$self->{'teacher'}->get });
	my $room=$self->{'schema'}->resultset('Room')
		->find({ 'name'=>$self->{'room'}->get });
	
	if(!defined($teacher))
	{
		$self->{'status'}='Несъществуващ учител';
	}
	elsif(!defined($room))
	{
		$self->{'status'}='Несъществуваща стая';
	}
	elsif($room->search_related('lectures', { 'returned'=>0 })->count>0)
	{
		$self->{'status'}='Тази стая е заета';
	}
	else {
		$self->{'schema'}->resultset('Lecture')->create({
				room_id    => $room->id,
				teacher_id => $teacher->id,
				start      => strftime("%Y-%m-%d %H:%M:%S", localtime(time)),
				returned   => 0,
			});
		$self->{'onSubmitCall'}();
	}
}