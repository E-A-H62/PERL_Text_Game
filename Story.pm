#!/usr/bin/perl

# implementation of story class
package Story;
use strict;
use warnings;

# constructor method for class
sub new {
    my $class = shift;
    my $self = {
        _thief => shift, # should be object of Thief class
        _city => shift,
    };
    bless $self, $class;
    return $self;
}

# get method that returns city name
sub getCityName {
    my ($self) = @_;
    return $self->{_city};
}

# method that sets city name
sub setCityName {
    my ($self, $city) = @_;
    $self->{_city} = $city if defined($city);
    return $self->{_city};
}

sub startStory {
    print "It's just another day in the city.\n";
    print "Except this time a new face has arrived.\n";
    print "~~~~~~~~~~\n";
    shift->explore(); # call method on current object
}

sub explore {
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "In such a large city, there are countless places to go.\n";
    print "There are also many places that have yet to be explored.\n";
    ##EXPLORE: # figure out how placement of this label affects how input is read
    print "What do you do?\n";
    my $string = <STDIN>;
    chomp($string);
    # label used to be here but caused infinite loop? Maybe since string wasn't read in?
    while ($string !~ /quit/i){
        if ($string =~ /black market/i){ # using i in the regex makes check case-insensitive
            $self->blackMarket();
        }
        if ($string =~ /psychic/i){ # using i in the regex makes check case-insensitive
            $self->psychicTent();
        }
        if ($string =~ /alley/i){ # using i in the regex makes check case-insensitive
            $self->darkAlley();
        }
        if ($string =~ /town square/i){ # using i in the regex makes check case-insensitive
            $self->townSquare();
        }
        if ($string =~ /tavern/i){ # using i in the regex makes check case-insensitive
            $self->tavern();
        }
        print "What else do you do?\n";
        $string = <STDIN>;
        chomp($string);
    }
}

sub blackMarket() {
    my ($self) = @_; # figure out what this line does
    print "This is where you would go if you went to the black market.\n";

    my $thief = $self->{_thief}; # also figure this out
    $thief->goToBlackMarket();
    print "This is where you would go after visiting the black market.\n";
}

sub psychicTent() {
    print "This is where you would go if you went to the psychic.\n";
}

sub darkAlley() {
    print "This is where you would go if you went to the alley.\n";
    #expand later
}

sub townSquare() {
    print "This is where you would go if you went to the town square.\n";
    #expand later
}

sub tavern() {
    print "This is where you would go if you went to the tavern.\n";
    #expand later
}

1;

