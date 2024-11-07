#!/usr/bin/perl

# implementation of story class
package Story;
use strict;
use warnings;

# method that initializes new object (hash reference)
sub new {
    # takes class name as argument
    my $class = shift;
    # takes other attributes as arguments
    my $self = {
        _thief => shift, # should be object of Thief class
        _city => shift,  # name of city
        _spied => 0,     # flag to show if user has spied
    };
    # blesses hash reference to turn it into an object of class Story
    bless $self, $class;
    return $self;
}

# get method that returns city name
sub getCityName {
    # extracts first argument passed to this methods
    # this argument should be an object (instance of Story class)
    my ($self) = @_;
    # gets _city attribute from object and returns its value
    return $self->{_city};
}

# method to begin text adventure
sub startStory {
    # allows method to access instance of Story class and its attributes
    my ($self) = @_;

    # prints description to start text adventure
    print "It's just another day in the city of " . $self->getCityName() . ".\n";
    print "The sun casts long shadows as you walk past the wide city gates.\n";
    print "You feel the pulse of the city around you, rich with life and full of activity.\n";
    print "Things are about to get interesting.\n";

    # sets of words to compare user input to
    my @exploreWords = ("explore", "walk", "enter");
    my @studyWords = ("look", "see", "watch");
    my @spyWords = ("spy", "observe", "study");
    
    # prompts user for input
    print "~~~~~~~~~~\n";
    print "What do you do?\n";
    my $string = <STDIN>; # stores input as string
    chomp($string); # removes newline character from input
    print "~~~~~~~~~~\n";

    # allows user to keep playing until they explicitly type they want to leave
    while($string !~ /quit/i and $string !~ /leave/i){  # using i in regex makes the check case-insensitive
        # checks if user asks for a hint
        if ($string =~ /hint/i) {
            # calls first hint method on instance of Story class
            $self->hint();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @exploreWords){
            # calls explore method on instance of Story class
            $self->explore();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @studyWords){
            # calls look method on instance of Story class
            $self->look();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @spyWords){
            # calls spy method on instance of Story class
            $self->spy();
        }
        # user did not enter any words in the accepted lists of words
        else {
            # suggests to a user to use a hint to find acceptable actions
            print "As much as you want to do just that, you know there's something else you should be doing.\n";
            print "(If you want a hint for what actions you should do, type 'hint')\n";
        }

        # prompts user for more input to continue playing
        print "~~~~~~~~~~\n";
        print "What now?\n";
        $string = <STDIN>;
        chomp($string);
        print "~~~~~~~~~~\n";
    }

    # label that indicates end of game
    END:
    # prints description before ending gameplay
    print "It's been a long day, but you've seen and done alot.\n";
    print "You find a quaint little inn and take your well-deserved rest.\n";
    print "Thank you for playing!\n";
}

# method for main exploration route of game
sub explore {
    # allows method to access instance of Story class and its attributes
    my ($self) = @_;

    # sets of words to compare user input to
    my @blackMarketWords = ("black market", "job board", "wall");
    my @alleyWords = ("alley", "backalley", "passageway");
    my @squareWords = ("town square", "plaza", "merchant");
    my @tavernWords = ("tavern", "inn", "right");

    # description for exploration route
    print "The city is a maze of streets and alleys, each holding secrets of their own.\n";
    print "As you make your way down the main thoroughfare, you see a large and worn job board nailed to a wall.\n";
    print "Ahead lies a bustling town square filled with people and merchant stalls.\n";
    print "Raucous laughter drifts from the right, and you see a few people stumble out of a tavern.\n";

    # prompts user for input
    print "~~~~~~~~~~\n";
    print "What do you wish to do?\n";
    my $string = <STDIN>;
    chomp($string);
    print "~~~~~~~~~~\n";

    # allows user to keep exploring until they explicitly type they want to leave the game
    while ($string !~ /quit/i){
        # checks if user asks for a hint
        if ($string =~ /hint/i) {
            # calls second hint method on instance of Story class
            $self->hint2();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @blackMarketWords){
            # calls black market method on instance of Story class
            $self->blackMarket();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @alleyWords){
            # calls dark alley method on instance of Story class
            $self->darkAlley();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @squareWords){
            # calls town square method on instance of Story class
            $self->townSquare();

            # prints description after user chooses to leave town square
            print "You step away from the bustling square.\n";
            print "Ready to continue exploring the city, you make your way back to the main street.\n";
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @tavernWords){
            # calls tavern method on instance of Story class
            $self->tavern();
        }
        # user did not enter any words in the accepted lists of words
        else {
            # suggests to a user to use a hint to find acceptable actions
            print "As much as you want to do just that, you know there's something else you should be doing.\n";
            print "(If you want a hint for what actions you should do, type 'hint')\n";
        }

        # prompts user for more input to continue playing
        print "~~~~~~~~~~\n";
        print "What else do you do?\n";
        $string = <STDIN>;
        chomp($string);
        print "~~~~~~~~~~\n";
    }
    # user indicated they wanted to leave the game
    # jumps to label that preceded code that ends gameplay
    goto END;
}

# method that prints description when user chooses to 'look'
sub look {
    print "Colorful banners and signs hang from the buildings all around you.\n";
    print "You see the typical assortment of buildings - taverns, shops, smithies.\n";
    print "You're sure you could find and see more if you walked around and explored.\n";
}

# method that sets up route for when user chooses to 'spy'
sub spy {
    # allows method to access instance of Story class and its attributes
    my ($self) = @_;

    # prints description when user chooses to 'spy'
    print "You take a moment to observe the crowd.\n";
    print "Some people hurry past you, others stroll down the street to browse the stalls.\n";
    print "You catch snippets of conversations from all around, but one in particular draws your attention.\n";
    print "Out of the corner of your eyes, you see a group of cloaked figures slink into a nearby alley.\n";

    # set spied flag to 1 (1 indicates user 'spied', 0 indicates user did not spy)
    $self->{_spied} = 1;
}

# method that enables gameplay in black market
sub blackMarket() {
    # allows method to access instance of Story class and its attributes
    my ($self) = @_;
    # allows method to access instance of Thief class
    my $thief = $self->{_thief};

    # prints description when user chooses to go to black market
    print "You walk up to the job board and scan the various papers, advertisements, and wanted posters.\n";
    print "You catch sight of a familiar symbol, something only a select few would know.\n";
    print "When you step back you catch the same symbol on the corner next to the job board.\n";
    print "You stealthily enter the alley and follow the symbols to navigate its twists and turns.\n";
    print "Soon you emerge from the shadows and step into a hidden avenue.\n";

    if ($thief->{_relic}) {
        print "You notice a hooded figure leaning against a wall by the entryway.\n";
        print "They're wearing the exact same type of cloak as they figures you saw earlier.\n";
        print "~~~~~~~~~~\n";
        print "Do you approach them?\n";
        my $string = <STDIN>;
        chomp($string);
        print "~~~~~~~~~~\n";
        if ($string =~ /y/i) {
            $thief->getRelic();
        } else {
            print "You decide now's not the time and return your attention back to the market around you.\n";
        }
    }

    print "Dimly lit by flickering lanterns, shady figures exchange goods and talk in soft whispers.\n";
    print "You see many stalls in this black market, but you stride to the one that catches your attention.\n";

    # calls method from thief object to continue gameplay in black market
    $thief->goToBlackMarket();

    # prints description after user chooses to leave black market
    print "After your dealings, you leave feeling excited and cautious.\n";
}

# method that allows gameplay in dark alley
sub darkAlley() {
    # allows method to access instance of Story class and its attributes
    my ($self) = @_;
    my $thief = $self->{_thief};
    print "You step cautiously into the dark alley.\n";
    
    # checks if player chose to spy earlier and prints different responses
    if ($self->{_spied}){
        print "You don't see the cloaked figures you spotted earlier.\n";
        print "However, you do notice an oddly placed brick in the wall.\n";
        $thief->goToAlley();
        print "\nYou have a chance to collect yourself now.\n";
    } else {
        # can edit this part so after checking spying can segue into checking inventory.
        print "The alley is deserted, and you have a chance to collect yourself.\n";
    }
    # make call method from instance of Thief to check inventory
    print "Now that you have a moment to yourself, you look over your assets.\n";
    $thief->seeAssets();
    print "You've checked what you wanted, so you decide to return to your exploring.\n";
}

# method that enables gameplay in town square
sub townSquare() {
    # allows method to access instance of Story class and its attributes
    my ($self) = @_;
    my $thief = $self->{_thief};

    # prints description for town square
    print "You find yourself in the town square.\n";
    print "Colorful stalls lined with fruits, trinkets, and fabrics fill the plaza near to bursting.\n";
    print "Children laugh and chase each other, while a bard strums a lively tune nearby.\n";
    print "You even see a colorful tent propped up next to the bubbling fountain.\n";
    print "The atmosphere is warm, filled with the promise of adventure and discovery.\n";
    
    # prompts for user input
    print "~~~~~~~~~~\n";
    print "What do you want to do in the town square?\n";
    my $string = <STDIN>;
    chomp($string);
    print "~~~~~~~~~~\n";

    # sets of words to compare user input to
    my @pyschicWords = ("tent", "pyschic", "fountain");
    my @shoppingWords = ("stalls", "merchants", "buy", "shopping");

    # allows user to keep exploring town square until they explicitly type they want to leave the area
    while ($string !~ /go back/i and $string !~ /leave/i){
        # checks if user asks for a hint
        if ($string =~ /hint/i) {
            # calls third hint method on instance of Story class
            $self->hint3();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @pyschicWords){
            # calls pyschic tent method on instance of Story class
            $self->psychicTent();
        }
        # checks if user input includes one of accepted words from list
        elsif (grep {$string =~ /$_/i} @shoppingWords){
            # include options to try different shopping routes
            $thief->goToApothecary();
        }
        # checks if user wants to end the game
        elsif ($string =~ /quit/i){
            goto END;
        }
        # user did not enter any words in the accepted lists of words
        else {
            # suggests to a user to use a hint to find acceptable actions
            print "As much as you want to do just that, you know there's something else you should be doing.\n";
            print "(If you want a hint for what actions you should do, type 'hint')\n";
        }

        # prompts for user input
        print "~~~~~~~~~~\n";
        print "What else do you do in the town square?\n";
        $string = <STDIN>;
        chomp($string);
        print "~~~~~~~~~~\n";
    }
}

# method that enables gameplay in psychic tent
sub psychicTent() {
    my ($self) = @_;
    my $thief = $self->{_thief};
    # prints description when user chooses to go to psychic tent
    print "You enter the psychic's tent, the air thick with incense and mystery.\n";
    print "A crystal ball glows softly in the dim light.\n";
    print "The psychic peers into it, her eyes clouded with visions of the future.\n";
    print "She looks up, her eyes clearing immediately, and gestures for you to sit.\n";
    # call method from instance of Thief
    $thief->getFortune();
}

# method that enables gameplay in tavern
sub tavern() {
    my ($self) = @_;
    my $thief = $self->{_thief};

    # prints description when user chooses to go to tavern
    print "You push open the heavy wooden door of the tavern and enter a well-lit room.\n";
    print "The low hum of conversation fills the room while the scent of ale and sawdust fills your nose.\n";
    print "While the atmosphere seems relaxed, it would be wise to tread carefully.\n";
    print "Not everything here is as it seems.\n";

    # call method from instance of Thief
    $thief->goToTavern();
}

# method that prints first set of hints for what user can do
sub hint {
    print "You can do one of the following:\n";
    print "- Explore the city\n";
    print "- Look around\n";
    print "- Spy on the crowd\n";
    print "- Leave the game (type 'leave' or 'quit')\n";
}

# method that prints second set of hints for what user can do
sub hint2 {
    print "You can do one of the following:\n";
    print "- Explore the black market\n";
    print "- Explore the alley\n";
    print "- Explore the town square\n";
    print "- Explore the tavern\n";
    print "- Leave the game (type 'quit')\n";
}

# method that prints third set of hints for what user can do
sub hint3 {
    print "You can do one of the following:\n";
    print "- Explore the pyschic's tent\n";
    print "- Explore the stalls\n";
    print "- Leave the plaza\n";
    print "- Exit the game (type 'quit')\n";
}

1; # must have at end of class definition

