#!/usr/bin/perl


package Tk::LectureEnd;
use base qw/Tk::Lecture/;
use strict;
use warnings;
use POSIX qw/strftime/;

Construct Tk::Widget 'LectureEnd';

sub submit {
	my ($self) = @_;
	my $teacher=$self->{'schema'}->resultset('Teacher')
		->find({ 'name'=>$self->{'teacher'}->get });
	my $room=$self->{'schema'}->resultset('Room')
		->find({ 'name'=>$self->{'room'}->get });
	
	if(!defined($teacher))
	{
		$self->{'status'}='No such teacher';
	}
	elsif(!defined($room))
	{
		$self->{'status'}='No such room';
	}
	else {
		my $lectures=$room->search_related('lectures', { 'returned'=>0 });
		if($lectures->count<1)
		{
			$self->{'status'}='The room is already free';
		}
		elsif($lectures->count>1)
		{
			die("More than one lecture in the same room. This shouldn't happen.");
		}
		else {
			my $lecture=$lectures->first;
			$lecture->end(strftime("%Y-%m-%d %H:%M:%S", localtime(time)));
			$lecture->returned(1);
			$lecture->update();
			$self->{'onSubmitCall'}();
		}
	}
}