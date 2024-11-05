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
    };
    bless $self, $class;
    return $self;
}

# can write getter and setter methods (or their equivalent) later if necessary

sub goToBlackMarket {
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "You are deep in the market now.\n";
    print "What do you do?\n";
    print "  ‣ Continue to Stroll? \n";
    print "  ‣ Leave?\n";
    my $string = <STDIN>;
    chomp($string);
    while ($string !~ /leave/){
        if ($string =~ /continue/){ 
            $self->vendorInteraction();
        }
        print "What else do you do?\n";
        $string = <STDIN>;
        chomp($string);
    }
}

sub vendorInteraction{
    my ($self) = @_;
    print "You approach the nearest vendor and look at his wares.\n";
    print "He has a multitude of different things.\n";
    print "On the floor, there are knives, bags, hats.\n";
    print "Vendor: 'Oh dear, I see that you have been eyeing my inventory' \n"; 
    print "Vendor: 'Is there anything you want?' \n";
    print "Ask about: \n"; 
    print "  ‣ Hats? \n";
    print "  ‣ Weapons?\n";
    print "  ‣ Bags?\n";
    print "  ‣ Potions?\n";
    print "  ‣ Leave\n";
    
    my $item_choice = <STDIN>;
    chomp($item_choice);
    while ($item_choice !~ /leave/) {
        if ($item_choice =~ /hats/) {
            $self->buyObject("Hat", 15);
        } elsif ($item_choice =~ /weapons/) {
            $self->buyObject("Weapon", 50);
        } elsif ($item_choice =~ /bags/) {
            $self->buyObject("Bag", 20);
        } elsif ($item_choice =~ /potions/) {
            $self->buyObject("Potion", 101);
        } else {
            print "That item is not available. Please choose something else.\n";
        }
        print "Do you want to buy anything else?\n";
        $item_choice = <STDIN>;
        chomp($item_choice);
    }
    print "You leave the vendor's stall.\n";
}

sub buyObject{
    my ($self, $item, $cost) = @_;
    if ($self->{_coins} >= $cost) {
        $self->{_coins} -= $cost;
        print "You bought a $item for $cost coins.\n";
        print "You have " . $self->{_coins} . " coins left.\n";
        push @{$self->{_inventory}}, $item;  # Add the item to the inventory
        $self->displayInventory();
        
    } else {
        print "You don't have enough coins to buy a $item.\n";
        print "Do you want to steal it?\n"; 
        my $response = <STDIN>;
        chomp($response);
        if ($response =~ /yes/) {
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
        $self->displayInventory(); 
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