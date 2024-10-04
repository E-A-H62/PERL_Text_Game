#!/usr/bin/perl
use strict;
use warnings;
use lib '.';
use Story;
use Thief;

# figure out how to pass array as argument (so tools could be array of elements)
my $newTheif = Thief->new(50, "Forgery", "None", 100, 20, 0);
#my $newStory = Story->new("Kalz", "Entin");

my $newStory = Story->new($newTheif, "Entin");
$newStory->explore();