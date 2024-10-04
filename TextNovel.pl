#!/usr/bin/perl
use strict;
use warnings;
use lib '.';
use Story;
use Thief;

# figure out how to pass array as argument (so tools could be array of elements)

my $newTheif = Thief->new(50, "Forgery", "None", 100, 20, 0); # creates instance of Thief class
my $newStory = Story->new($newTheif, "Entin"); # creates instance of Story class
$newStory->startStory(); # begins text adventure