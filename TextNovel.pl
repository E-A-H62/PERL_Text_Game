#!/usr/bin/perl
use strict;
use warnings;
use lib '.';
use Story;
use Thief;

my $newThief = Thief->new(50, 100, 20, 0); # creates instance of Thief class
my $newStory = Story->new($newThief, "Entin"); # creates instance of Story class
$newStory->startStory(); # begins text adventure
