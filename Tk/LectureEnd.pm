#!/usr/bin/perl


package Tk::LectureEnd;
use base qw/Tk::Lecture/;
use strict;
use warnings;
use POSIX qw/strftime/;
use utf8;

Construct Tk::Widget 'LectureEnd';

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
	else {
		my $lectures=$room->search_related('lectures', { 'returned'=>0 });
		if($lectures->count<1)
		{
			$self->{'status'}='Тази стая вече е освободена';
		}
		elsif($lectures->count>1)
		{
			die("More than one lecture in the same room. This shouldn't happen.");
		}
		else {
			my $lecture=$lectures->first;
			if($lecture->teacher_id!=$teacher->id)
			{
				$self->{'status'}='Стаята е заета от '
						.$lecture->teacher->name.', а не '.$teacher->name;
			}
			else {
				$lecture->end(strftime("%Y-%m-%d %H:%M:%S", localtime(time)));
				$lecture->returned(1);
				$lecture->update();
				$self->{'onSubmitCall'}();
			}
		}
	}
}

sub Populate {
	my ($self, $args) = @_;
	$self->SUPER::Populate($args);
	
	# When the teacher field is set, automatically fill in the
	# room field with the name of the occupied room
	$self->{'teacher'}->bind('<KeyRelease>' => sub {
			my $teacher=$self->{'schema'}->resultset('Teacher')
				->find({ 'name'=>$self->{'teacher'}->get });
			if(defined($teacher))
			{
				my $lectures=$teacher->search_related('lectures', { returned=>0 },
						{ 'prefetch'=>'room' });
				if($lectures->count>0)
				{
					$self->{'room'}->delete(0,'end');
					$self->{'room'}->insert('end', $lectures->first->room->name);
				}
			}
		});
}

1;