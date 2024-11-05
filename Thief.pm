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
        _health => shift, #int representing the HP of user 
        _specialty => shift, #char/string represeting the spcialty of user 
        _tools => shift, # char/string representing the tool or tools user has
        _coins => shift, #int representing the num of coins 
        _rep => shift, #int representing reputation
        _caught => shift, #int representing the number of times users is caught
        _inventory => []
    };
    bless $self, $class;
    return $self;
}

# can write getter and setter methods (or their equivalent) later if necessary

sub goToBlackMarket {
    my ($self) = @_;
    print "You approach the nearest vendor and look at the few wares on the table.\n";
    print "Vendor: I can see you're someone who knows what they want.\n"; 
    print "Vendor: What is it you're looking for?\n";
    print "Ask about: \n"; 
    print "  ‣ Hats? \n";
    print "  ‣ Weapons?\n";
    print "  ‣ Bags?\n";
    print "  ‣ Potions?\n";
    print "  ‣ Leave\n";
    
    my $item_choice = <STDIN>;
    chomp($item_choice);
    while ($item_choice !~ /leave/i) {
        if ($item_choice =~ /hats/i) {
            $self->buyObject("Hat", 15);
        } elsif ($item_choice =~ /weapons/i) {
            $self->buyObject("Weapon", 50);
        } elsif ($item_choice =~ /bags/i) {
            $self->buyObject("Bag", 20);
        } elsif ($item_choice =~ /potions/i) {
            $self->buyObject("Potion", 101);
        } elsif ($item_choice =~ /no/i) {
            last;
        } else {
            print "That item is not available. Please choose something else.\n";
        }
        print "Vendor: Thank you kindly for your patronage.\n";
        print "Vendor: Would you care for anything else?\n";
        $item_choice = <STDIN>;
        chomp($item_choice); 
    }
    print "Vendor: You know where to find me the next time you need something.\n";
}

sub buyObject{
    my ($self, $item, $cost) = @_;
    if ($self->{_coins} >= $cost) {
        $self->{_coins} -= $cost;
        print "You bought a $item for $cost coins.\n";
        print "You have " . $self->{_coins} . " coins left.\n";
        push @{$self->{_inventory}}, $item;  # Add the item to the inventory        
    } else {
        print "You don't have enough coins to buy a $item.\n";
        print "Do you want to steal it?\n"; 
        my $response = <STDIN>;
        chomp($response);
        if ($response =~ /yes/i) {
            $self->stealObject($item);
        } else {
            print "You decide not to steal the $item.\n";
        }
   
    }
}

sub stealObject{
    my ($self, $item) = @_;
    my $success_chance = int(rand(100));  # Generate a random 
    if ($success_chance < 50) {  # 50% chance of successful steal
        print "You successfully stole the $item!\n";
        push @{$self->{_inventory}}, $item; 
    } else {
        print "You were caught trying to steal the $item!\n";
        $self->{_caught} += 1;  # Increase the caught counter
        print "Your 'caught' count is now: " . $self->{_caught} . "\n";
    }
}

sub displayInventory {
    my ($self) = @_;
    print "Your inventory contains: " . join(", ", @{$self->{_inventory}}) . "\n";
}

sub getFortune {
    print "This is when you get your fortune read...\n";
}

sub goToAlley {
    # added just in case
    my ($self) = @_;
    print "This is what you will see after spying.\n";
}

sub goToApothecary {
    # to be added
    my ($self) = @_;
    print "This is where you will go shopping.\n";
}

sub goToTavern {
    # to be added
    my ($self) = @_;
    print "You can't do anything here yet!\n";
}

sub goToBar {
    # to be added 
}

sub drinkingGame {
    #to be added 
}

1; # must have at end of class definition