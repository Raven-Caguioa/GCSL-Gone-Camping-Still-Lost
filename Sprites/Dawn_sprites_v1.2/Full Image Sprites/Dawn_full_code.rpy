init offset = -1
###########################

## Hello!
## Please follow the instructions on the lines preceeded by a single hashtag (#) to configure this sprite for use! (in 'Character' section and 'Blinking Character Images' section!)
## Changes to make: 1), 2a), 2b), 2c), 2d), 2e), 2f).

###### Transforms/transitions for expressions/blinks ######
define config.say_attribute_transition = Dissolve(0.2)
transform blinkwait:
    choice:
        10.0
    choice:
        6.0
    choice:
        4.5
    choice:
        3.0

###### Character ##################################
define d = Character("Dawn", image="Dawn") # 1) Change the 2 "Dawn"s to your character's name (eg. "Alex"), and 'd' to your character's letter!

###### Blinking Character Images ##################
image Dawn normal: # 2a) Change 'Dawn' on this line to your character's name!
    "Dawn/Dawn_normal.png"
    blinkwait
    "Dawn/Dawn_normal_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_normal.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn normal2: # 2b) Change 'Dawn' on this line to your character's name!
    "Dawn/Dawn_normal2.png"
    blinkwait
    "Dawn/Dawn_normal2_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_normal2.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn lookaway: # 2c) Change 'Dawn' on this line to your character's name!
    "Dawn/Dawn_lookaway.png"
    blinkwait
    "Dawn/Dawn_lookaway_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_lookaway.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn surprised: # 2d) Change 'Dawn' on this line to your character's name!
    "Dawn/Dawn_surprised.png"
    blinkwait
    "Dawn/Dawn_surprised_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_surprised.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn pout: # 2e) Change 'Dawn' on this line to your character's name!
    "Dawn/Dawn_pout.png"
    blinkwait
    "Dawn/Dawn_pout_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_pout.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn smile: # 2f) Change 'Dawn' on this line to your character's name!
    "Dawn/Dawn_smile.png"
    blinkwait
    "Dawn/Dawn_smile_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_smile.png" with Dissolve(0.2)
    0.1
    repeat

########## HOW TO USE ################################

## Expressions: normal, normal2, lookaway, smile, pout, surprised

###################

## To change expressions, you can state it using the 'show' statement or through normal dialogue.

## Examples:

########### Show Statement #################
## show Dawn normal with Dissolve(0.2)
## show Dawn pout with Dissolve(0.2) --> changes expression
############################################

########### During dialogue ################
## d normal "Blah Blah Blah" ---> Just state the expression after your character's letter symbol during dialogue.
## d pout "Blah Blah Blah" --> Changes just the expression from the above one
############################################

## For more info on using character images, please check Renpy Documentation.
## Enjoy!
