#!/usr/bin/perl

# implementation of story class
package Thief;
use strict;
use warnings;

# constructor method for class
# can remove/add things as needed
sub new {
    # takes class name as argument
    my $class = shift;
    # takes other attributes as arguments
    my $self = {
        _health => shift, #int representing the HP of user 
        _coins => shift, #int representing the num of coins 
        _rep => shift, #int representing reputation
        _caught => shift, #int representing the number of times users is caught
        _inventory => [],
        _healthy => 1, #int representing if user is healthy
        _relic => 0,
    };
    # blesses hash reference to turn it into an object of class Story
    bless $self, $class;
    return $self;
}

# method for when user goes shopping in black market
sub goToBlackMarket {
    # allows method to access instance of Thief class and its attributes
    my ($self) = @_;

    # prints description when user goes to buy from vendor
    print "You approach the nearest vendor and look at the few wares on the table.\n";
    print "Vendor: I can see you're someone who knows what they want.\n"; 
    print "Vendor: What is it you're looking for?\n";

    # prompts user for input
    print "Ask about: \n"; 
    print "  ‣ Hats? \n";
    print "  ‣ Weapons?\n";
    print "  ‣ Bags?\n";
    print "  ‣ Potions?\n";
    print "  ‣ Leave\n";
    my $item_choice = <STDIN>;
    chomp($item_choice);

    # allows user to keep shopping until they type they want to leave
    while ($item_choice !~ /leave/i) {
        # checks if user asks about hats
        if ($item_choice =~ /hats/i) {
            # method call to buy a hat
            $self->buyObject("Hat", 15);
        # checks if user asks about weapons
        } elsif ($item_choice =~ /weapons/i) {
            # method call to buy a weapon
            $self->buyObject("Weapon", 50);
        # checks if user asks about bag
        } elsif ($item_choice =~ /bags/i) {
            # method call to buy a bag
            $self->buyObject("Bag", 20);
        # checks if user asks about potions
        } elsif ($item_choice =~ /potions/i) {
            # method call to buy a potion
            $self->buyObject("Potion", 101);
        # checks if user enters they don't want to shop any more
        } elsif ($item_choice =~ /no/i) {
            last; # breaks out of while loop
        # user entered invalid input
        } else {
            print "That item is not available. Please choose something else.\n";
        }
        # user prompted to enter if they want to buy anything else
        print "Vendor: Thank you kindly for your patronage.\n";
        print "Vendor: Would you care for anything else?\n";
        $item_choice = <STDIN>;
        chomp($item_choice); 
    }
    # prints out message before user leaves vendor
    print "Vendor: You know where to find me the next time you need something.\n";
}

# method for when user goes buy object
sub buyObject {
    # array assignment where variables store values in array so they can be passed to method
    my ($self, $item, $cost) = @_;

    # checks if user has enough coins to buy items
    if ($self->{_coins} >= $cost) {
        $self->{_coins} -= $cost; # subtracts cost from user's coins
        print "You bought a $item for $cost coins.\n";
        print "You have " . $self->{_coins} . " coins left.\n";
        push @{$self->{_inventory}}, $item;  # adds item to inventory by append it to array
    # user does not have enough coins
    } else {
        # asks if user wants to steal item
        print "You don't have enough coins to buy a $item.\n";
        print "Do you want to steal it?\n"; 
        my $response = <STDIN>;
        chomp($response);
        if ($response =~ /yes/i) {
            # method call so user can try stealing item
            $self->stealObject($item);
        } else {
            print "You decide not to steal the $item.\n";
        }
   
    }
}

# method for when user tries steal object
sub stealObject {
    # array assignment where variables store values in array so they can be passed to method
    my ($self, $item) = @_;
    my $success_chance = int(rand(100) + $self->{_rep});  # Generate a random
    # checks if user successfully stole item
    if ($success_chance < 50) {  # 50% chance of successful steal
        $self->{_rep} += 5;
        print "You successfully stole the $item!\n";
        push @{$self->{_inventory}}, $item; # adds stolen item to inventory
    # user did not succeed at stealing the item
    } else {
        print "You were caught trying to steal the $item!\n";
        $self->{_caught} += 1;  # increases caught counter by one
        print "Your 'caught' count is now: " . $self->{_caught} . "\n";
    }
}

# method for when user gets object
sub getObject {
    my ($self, $item) = @_;
    # adds item to inventory by append item to array representing inventory
    push @{$self->{_inventory}}, $item;
    print "*$item acquired.*\n";
}

# method to display user inventory
sub displayInventory {
    # allows method to access instance of Thief class and its attributes
    my ($self) = @_;
    # prints out inventory after accessing array holding elements of inventory
    print "Your inventory contains: " . join(", ", @{$self->{_inventory}}) . "\n";
}

# method to allow user to check their assets
sub seeAssets {
    # allows method to access instance of Thief class and its attributes
    my ($self) = @_;

    # prints out list of things user can check and prompts them to pick one
    print "What would you like to check?\n"; 
    print "  ‣ Health\n";
    print "  ‣ Inventory\n";
    print "  ‣ Coins\n";
    print "  ‣ Reputation\n";
    print "  ‣ Nothing\n";
    my $choice = <STDIN>;
    chomp($choice);

    # allows user to keep checking their assets until they want to stop
    while ($choice !~ /nothing/i) {
        # checks if user wants to see their health points
        if ($choice =~ /health/i) {
            # prints out users health points
            print "You currently have a health of " . $self->{_health} . ".\n";
            # checks if user is sick (healthy flag is set to 0), and prints it our if they are
            if ($self->{_healthy} eq 0) {
                print "You are also sick.\n";
                print "It might be a good idea to buy medicine.\n";
            }
        # checks if user wants to see their inventory
        } elsif ($choice =~ /inventory/i) {
            # method call to display inventory
            $self->displayInventory();
        # checks if user wants to see their coins
        } elsif ($choice =~ /coins/i) {
            # prints out coins user has
            print "You currently have " . $self->{_coins} . " coins.\n";
        # checks if user wants to see their reputation
        } elsif ($choice =~ /reputation/i) {
            # prints out number of times user was caught and their current reputation points
            print "You have been caught stealing " . $self->{_caught} . " times.\n";
            print "You currently have a reputation of " . $self->{_rep} . ".\n";
        # user entered invalid option
        } else {
            print "That is not something you can check.\n";
            print "Please try checking something else.\n";
        }
        # prompts user if they want to keep checking their assets
        print "What else would you like check?\n";
        $choice = <STDIN>;
        chomp($choice); 
    }
}

# method when user goes to get fortune from fortune teller
sub getFortune {
    # prompts user to choose what they want the fortune teller to tell
    print "Fortune Teller: I was wondering when you'd arrive.\n";
    print "Fortune Teller: Would you like me read your aura, or shall I attempt to tell the future?\n";
    print "Ask about: \n"; 
    print "  ‣ Auras\n";
    print "  ‣ The future\n";
    my $choice = <STDIN>;
    chomp($choice);

    # allows user to remain at psychic tent until they want to leave
    while ($choice !~ /leave/i) {
        # checks if user wants their auras read
        if ($choice =~ /auras/i) {
            print "Fortune Teller: Let's not wait, the auras are telling you...\n";
            # array of strings holding "fortunes"
            my @fortunes = (
                "Beware of hooded strangers.\n",
                "Do not agree to the proposition.\n",
                "The best is still to come.\n",
                "All your effort will pay off soon.\n",
                "Make sure to stay healthy.\n"
            );
            # randomly chooses fortune string and prints it out
            my $fortune = int(rand(5));
            print $fortunes[$fortune];
        # checks if user wants their future told
        } elsif ($choice =~ /future/i) {
            print "Fortune Teller: Okay, just be prepared for some pretty vague readings.\n";
            print "Fortune Teller: Telling the future gets tricky.\n";
            # array of strings holding "futures"
            my @futures = (
                "You will get what you seek.\n",
                "You will face one of your worst failures.\n",
                "You will make a new friend.\n",
                "You will get sick.\n",
            );
            # randomly chooses future string and prints it
            my $future = int(rand(4));
            print $futures[$future];
            print "The fortune teller seems to fall into a trance.\n";
            print "The fortune teller seems to break out of her trance.\n";
            print "Fortune Teller: I hope you heard something interesting at least.\n";
        # checks if user is done asking for fortunes or futures
        } elsif ($choice =~ /no/i) {
            last; # breaks out of while loop
        # user enters invalid input
        } else {
            print "Fortune Teller: I'm sorry, that's not something I can do.\n";
        }
        # prompts user if they want to keep getting their fortunes or futures told
        print "Fortune Teller: Is there anything else I can do for you?\n";
        $choice = <STDIN>;
        chomp($choice); 
    }
    print "Fortune Teller: I await your next visit.\n";
}

# method when user goes to alley and unlocks relic route
sub goToAlley {
    # allows method to access instance of Thief class and its attributes
    my ($self) = @_;

    # prints description as user unlocks relic route
    print "You reach for the brick and your fingers brush against a leaf of paper.\n";
    print "You pull out the brick and remove a crumpled note which contains a single line:\n";
    print "'The relic is at the market of shadows.'\n";
    print "You replace the note and brick, intrigued.\n";
    print "Perhaps you should go back to the black market.\n";
    $self->{_relic} = 1; # sets flag to 1 to indicate user unlocked relic route
}

sub getRelic {
    # allows method to access instance of Thief class and its attributes
    my ($self) = @_;

    # checks if user's reputation is above or equal to 100
    if ($self->{_rep} >= 100) {
        print "Hooded Stranger: I was wondering when you'd show up.\n";
        print "Hooded Stranger: You've made a name for yourself, there's no doubt about that.\n";
        print "Hooded Stranger: Just know I'm only handing this over because of my orders.\n";
        $self->getObject("Relic"); # method call for user to get relic
        $self->{_relic} = -1; # sets flag to -1 to indicate user finished unlocked relic route
        print "Try not to mess anything up.\n";
    }
    # user doesn't have enough reputation to unlock relic route
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
    # allows method to access instance of Thief class and its attributes
    my ($self) = @_;

    # prints description when user goes to apothecary
    print "You weave around the bustling crowd and pass the bard on your way to the fountain.\n";
    print "The other stands may have interesting trinkets, ";
    print "but the vendor up ahead has the only things you're interested in.\n";
    print "You step forward and are instantly hit with the scent of countless herbs.\n";
    print "Glass vials stand in neat rows on the covered table alongside piles of stacked containers.\n";
    print "Apothecary: Good day to you, my friend. What can I help you with?\n";
    # prompts user for what they want
    print "Ask about: \n"; 
    print "  ‣ Medicine \n";
    print "  ‣ Leave\n";
    my $choice = <STDIN>;
    chomp($choice);

    # allows user to keep shopping at apothecary until they want to leave
    while ($choice !~ /leave/i) {
        # checks if user wants to buy medicine
        if ($choice =~ /medicine/i) {
            # method call so user can get medicine
            $self->getMedicine();
        # checks if user doesn't want to buy anything else
        } elsif ($choice =~ /no/i) {
            last; # breaks out of while loop
        # user entered invalid input
        } else {
            print "Apothecary: I'm sorry, I can't help you with that.\n";
        }
        # prompts user if they want to keep shopping
        print "Apothecary: Would you care for anything else?\n";
        $choice = <STDIN>;
        chomp($choice); 
    }
    print "Apothecary: If you're ever feeling under the weather I'll be here.\n";
}

sub getMedicine {
    # allows method to access instance of Thief class and its attributes
    my ($self) = @_;

    # checks if user is healthy (doesn't need need medicine)
    if ($self->{_healthy}) {
        print "Apothecary: You're not sick, so you don't need this medicine.\n";
        print "Apothecary: Trust me, you'll regret having to take it if you don't need it.\n";
    # checks if user needs medicine
    } else {
        print "Apothecary: Ah, I have just the thing for you.\n";
        print "Apothecary: The medicine you'll need is 10 coins.\n";
        # asks if user wants to buy medicine
        print "Pay?\n";
        print "Select y/n: ";
        chomp(my $choice = <STDIN>);
        # checks if user wants to buy medicine
        if ($choice eq "y") {
            # method call so user can buy medicine
            $self->buyObject("Medicine", 10);
        # checks if user doesn't want to buy medicine
        } else {
            print "Apothecary: If you say so.\n";
        }
    }
}

sub goToTavern {
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "You have entered the Tavern.\n";
    print "While the atmosphere seems relaxed, it would be wise to tread carefully.\n";
    print "You notice the people around, taking note of each one.\n";

    my $choice;
    do {
        print "~~~~~~~~~~\n";
        print "Choose an action:\n";
        print "  ‣ Go to the Bar\n";
        print "  ‣ Continue to Observe\n";
        print "  ‣ Leave the tavern\n";
        
        $choice = <STDIN>;
        chomp($choice);
        
        if ($choice =~ /go to the bar/i) {
            $self->goToBar();
        } elsif ($choice =~ /continue to observe/i) {
            $self->observePeople();
        }
    } while ($choice !~ /leave/i);
    
    print "You decide to leave the tavern.\n";
}

sub goToBar {
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print "You approach the bar and sit on a bar stool.\n";
    print "The bartender looks over to you while wiping a glass.\n";
    print "Bartender: Hey, how's it going? What do you need?\n";

    my $choice;
    do {
        print "~~~~~~~~~~\n";
        print "Choose an action:\n";
        print "  ‣ Buy a drink\n";
        print "  ‣ Play Drinking game\n";
        print "  ‣ Leave the bar\n";
        
        $choice = <STDIN>;
        chomp($choice);
        
        if ($choice =~ /buy a drink/i) {
            $self->buyDrink();
        } elsif ($choice =~ /play drinking game/i) {
            $self->drinkingGame();
        }
    } while ($choice !~ /leave/i);
    
    print "Bartender: You know where to find me!\n";
    print "You leave the bar area.\n";
}

sub drinkingGame {
    my ($self) = @_;
    print "~~~~~~~~~~\n";
    print"Bartender: I see you have heard of the drinking contest we hold!\n"; 
    print"Bartender: The purpose of the game is to see who can drink the enitre bottle of Jägger in 7 seconds\n";
    print"Bartender: If you finish bottle, You will get 50 coins, and won't have to pay for the bottle\n"; 
    print"Bartender: So do you want to participate?\n"; 
    print "  ‣ Yes\n";
    print "  ‣ No\n";
    my $choice = <STDIN>;
    chomp($choice);

    if($choice=~/yes/i){
        print "You brace yourself for the challenge and start drinking!\n";
        # Simulating success/failure based on random chance
        my $success = int(rand(2));
        if ($success) {
            print "Congratulations! You finish the bottle in time and earn 50 coins!\n";
            $self->{_coins} += 50;
            print "You have " . $self->{_coins} . " coins.\n";
        } else {
            print "You couldn't finish in time. Better luck next time!\n";
            print "Bartender: Now you have to pay for the bottle, and its 50 coins\n"; 
            $self->{_coins}-=50; 
            print "You have " . $self->{_coins} . " coins.\n";
        }
    }
    elsif($choice=~/no/i){
        print "Bartender: No worries, maybe next time!\n";
    }
    
}

sub buyDrink {
    my ($self) = @_;
    my $drink_cost = 5;  # Set cost of drink
    if ($self->{_coins} >= $drink_cost) {
        $self->{_coins} -= $drink_cost;
        print "You buy a drink for $drink_cost coins. Enjoy!\n";
        print "You have " . $self->{_coins} . " coins left.\n";
    } else {
        print "You don't have enough coins to buy a drink.\n";
    }
}

sub observePeople {
    my ($self) = @_;
    my $choice;
    do {
        print "You take a seat and start observing the people around you.\n";
        print "There's a mix of locals, travelers, and a few shady figures.\n";
        print "~~~~~~~~~~\n";
        print "Would you like to:\n";
        print "  ‣ Continue observing\n";
        print "  ‣ Go back to the tavern menu\n";
        
        $choice = <STDIN>;
        chomp($choice);
        
        if ($choice =~ /continue observing/i) {
            print "You keep observing, hoping to catch something interesting.\n";
        }
    } while ($choice !~ /go back/i);
    
    print "You decide to stop observing and return to the main tavern area.\n";
}


1; # must have at end of class definition