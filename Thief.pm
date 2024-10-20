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
    print "  ‣ Enter? \n";
    print "  ‣ Leave?\n";
    my $string = <STDIN>;
    chomp($string);
    while ($string !~ /leave/i){
        if ($string =~ /enter/i){ # figure out how to use logical operations (ex: or, and)
            print "You approach the nearest vendor and look at his wares.\n";
            # can have shopping route here
        }
        print "What else do you do?\n";
        $string = <STDIN>;
        chomp($string);
    }
}

sub buyObject{
    #helper for black market if needed
}

sub stealObject{
    #helper for black market if needed 
}

sub getFortune {
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "You see a colorful tent near the center of the square.\n";
    print "As you get closer you see an elegant sign that reads 'Psychic'.\n";
    print "What do you do?\n";
    print "  ‣ Enter? \n";
    print "  ‣ Leave?\n";
    my $string = <STDIN>;
    chomp($string);
    while ($string !~ /leave/i){
        if ($string =~ /enter/i){
            print "You walk inside and immediately feel a sense of calm.\n";
            # can have fortune-telling route here
        }
        print "What else do you do?\n";
        $string = <STDIN>;
        chomp($string);
    }
}



sub goToAlley{
    # added just in case
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "Your at the Alley.\n";
    print "You can't do anything here yet!\n";
}

sub goToSquare{
    # added just in case
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "Your at the Sqaure.\n";
    print "You can't do anything here yet!\n";
}

sub goToTavern{
    # added just in case
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "Your at the Tavern.\n";
    print "You can't do anything here yet!\n";
}

sub goToBar{
    # to be added 
}

sub drinkingGame{
    #to be added 
}

1; # must have at end of class definition