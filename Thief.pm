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
        _coins => shift, #int representing the num of coins 
        _rep => shift, #int representing reputation
        _caught => shift, #int representing the number of times users is caught
        _inventory => [],
        _healthy => 1, #int representing if user is healthy
        _relic => 0,
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

sub buyObject {
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

sub stealObject {
    my ($self, $item) = @_;
    my $success_chance = int(rand(100) + $self->{_rep});  # Generate a random 
    if ($success_chance < 50) {  # 50% chance of successful steal
        $self->{_rep} += 5;
        print "You successfully stole the $item!\n";
        push @{$self->{_inventory}}, $item; 
    } else {
        print "You were caught trying to steal the $item!\n";
        $self->{_caught} += 1;  # Increase the caught counter
        print "Your 'caught' count is now: " . $self->{_caught} . "\n";
    }
}

sub getObject {
    my ($self, $item) = @_;
    push @{$self->{_inventory}}, $item;
    print "*$item acquired.*\n";
}

sub displayInventory {
    my ($self) = @_;
    print "Your inventory contains: " . join(", ", @{$self->{_inventory}}) . "\n";
}

sub seeAssets {
    my ($self) = @_;
    print "What would you like to check?\n"; 
    print "  ‣ Health\n";
    print "  ‣ Inventory\n";
    print "  ‣ Coins\n";
    print "  ‣ Reputation\n";
    print "  ‣ Nothing\n";

    my $choice = <STDIN>;
    chomp($choice);
    while ($choice !~ /nothing/i) {
        if ($choice =~ /health/i) {
            print "You currently have a health of " . $self->{_health} . ".\n";
            if ($self->{_healthy} eq 0) {
                print "You are also sick.\n";
                print "It might be a good idea to buy medicine.\n";
            }
        } elsif ($choice =~ /inventory/i) {
            $self->displayInventory();
        } elsif ($choice =~ /coins/i) {
            print "You currently have " . $self->{_coins} . " coins.\n";
        } elsif ($choice =~ /reputation/i) {
            print "You have been caught stealing " . $self->{_caught} . " times.\n";
            print "You currently have a reputation of " . $self->{_rep} . ".\n";
        } else {
            print "That is not something you can check.\n";
            print "Please try checking something else.\n";
        }
        print "What else would you like check?\n";
        $choice = <STDIN>;
        chomp($choice); 
    }
}

sub getFortune {
    print "Fortune Teller: I was wondering when you'd arrive.\n";
    print "Fortune Teller: Would you like me read your aura, or shall I attempt to tell the future?\n";
    print "Ask about: \n"; 
    print "  ‣ Auras\n";
    print "  ‣ The future\n";
    my $choice = <STDIN>;
    chomp($choice);

    while ($choice !~ /leave/i) {
        if ($choice =~ /auras/i) {
            print "Fortune Teller: Let's not wait, the auras are telling you...\n";
            my @fortunes = (
                "Beware of hooded strangers.\n",
                "Do not agree to the proposition.\n",
                "The best is still to come.\n",
                "All your effort will pay off soon.\n",
                "Make sure to stay healthy.\n"
            );
            my $fortune = int(rand(5));
            print $fortunes[$fortune];
        } elsif ($choice =~ /future/i) {
            print "Fortune Teller: Okay, just be prepared for some pretty vague readings.\n";
            print "Fortune Teller: Telling the future gets tricky.\n";
            my @futures = (
                "You will get what you seek.\n",
                "You will face one of your worst failures.\n",
                "You will make a new friend.\n",
                "You will get sick.\n",
            );
            my $future = int(rand(4));
            print "The fortune teller seems to fall into a trance.\n";
            print "The fortune teller seems to break out of her trance.\n";
            print "Fortune Teller: I hope you heard something interesting at least.\n";
        } elsif ($choice =~ /no/i) {
            last; # breaks out of while loop
        } else {
            print "Fortune Teller: I'm sorry, that's not something I can do.\n";
        }
        print "Fortune Teller: Is there anything else I can do for you?\n";
        $choice = <STDIN>;
        chomp($choice); 
    }
    print "Fortune Teller: I await your next visit.\n";
}

sub goToAlley {
    # added just in case
    my ($self) = @_;
    print "You reach for the brick and your fingers brush against a leaf of paper.\n";
    print "You pull out the brick and remove a crumpled note which contains a single line:\n";
    print "'The relic is at the market of shadows.'\n";
    print "You replace the note and brick, intrigued.\n";
    print "Perhaps you should go back to the black market.\n";
    $self->{_relic} = 1;
}

sub getRelic {
    my ($self) = @_;
    if ($self->{_rep} >= 100) {
        print "Hooded Stranger: I was wondering when you'd show up.\n";
        print "Hooded Stranger: You've made a name for yourself, there's no doubt about that.\n";
        print "Hooded Stranger: Just know I'm only handing this over because of my orders.\n";
        $self->getObject("Relic");
        $self->{_relic} = -1;
        print "Try not to mess anything up.\n";
    }
    else {
        print "Hooded Stranger: Whoever you are, walk away now.\n";
        print "Hooded Stranger: Whatever you want, go buy it from the fine merchants all around us.\n";
        print "Hooded Stranger: A no-name petty thief has no business with me.\n";
    }
    print "The stranger pushes off the wall and brushes past you.\n";
    print "Before you can stop them, they seem to vanish into the shadows of an alleyway.\n";
    print "You're left to your own devices now.\n\n";
}

sub goToApothecary {
    # to be added
    my ($self) = @_;
    print "You weave around the bustling crowd and pass the bard on your way to the fountain.\n";
    print "The other stands may have interesting trinkets, ";
    print "but the vendor up ahead has the only things you're interested in.\n";
    print "You step forward and are instantly hit with the scent of countless herbs.\n";
    print "Glass vials stand in neat rows on the covered table alongside piles of stacked containers.\n";
    print "Apothecary: Good day to you, my friend. What can I help you with?\n";
    print "Ask about: \n"; 
    print "  ‣ Medicine \n";
    print "  ‣ Leave\n";

    my $choice = <STDIN>;
    chomp($choice);
    while ($choice !~ /leave/i) {
        if ($choice =~ /medicine/i) {
            $self->getMedicine();
        } elsif ($choice =~ /no/i) {
            last;
        } else {
            print "Apothecary: I'm sorry, I can't help you with that.\n";
        }
        print "Apothecary: Would you care for anything else?\n";
        $choice = <STDIN>;
        chomp($choice); 
    }
    print "Apothecary: If you're ever feeling under the weather I'll be here.\n";
}

sub getMedicine {
    my ($self) = @_;
    if ($self->{_healthy}) {
        print "Apothecary: You're not sick, so you don't need this medicine.\n";
        print "Apothecary: Trust me, you'll regret having to take it if you don't need it.\n";
    } else {
        print "Apothecary: Ah, I have just the thing for you.\n";
        print "Apothecary: The medicine you'll need is 10 coins.\n";
        print "Pay?\n";
        print "Select y/n: ";
        chomp(my $choice = <STDIN>);
        
        if ($choice eq "y") {
            $self->buyObject("Medicine", 10);
        } else {
            print "Apothecary: If you say so.\n";
        }
    }
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