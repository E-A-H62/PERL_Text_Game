#!/usr/bin/perl

# implementation of story class
package Thief;
use strict;
use warnings;

# constructor method for class
# can remove/add things as needed
sub new {
    my $class = shift;
    my $self = {
        _health => shift,
        _specialty => shift,
        _tools => shift,
        _coins => shift,
        _rep => shift,
        _caught => shift,
    };
    bless $self, $class;
    return $self;
}

# can write getter and setter methods (or their equivalent) later if necessary

sub goToBlackMarket {
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "You catch sight of a hidden symbol.\n";
    print "Being as experienced as you are, you know exactly what it represents.\n";
    print "Following the different clues you make your way to the black market.\n";
    print "What do you do?\n";
    my $string = <STDIN>;
    chomp($string);
    while ($string !~ /leave/i){
        if ($string =~ /vendor/i){ # figure out how to use logical operations (ex: or, and)
            print "You approach the nearest vendor and look at his wares.\n";
            # can have shopping route here
        }
        print "What else do you do?\n";
        $string = <STDIN>;
        chomp($string);
    }
}

sub getFortune {
    my ($self) = @_;
    print "You see a colorful tent near the center of the square.";
    print "As you get closer you see an elegant sign that reads 'Psychic'.";
    print "What do you do?\n";
    my $string = <STDIN>;
    chomp($string);
    while ($string !~ /leave/i){
        if ($string =~ /enter/i){
            print "You walk inside and immediately feel a sense of calm.";
            # can have fortune-telling route here
        }
        print "What else do you do?\n";
        $string = <STDIN>;
        chomp($string);
    }
}

1; # must have at end of class definition