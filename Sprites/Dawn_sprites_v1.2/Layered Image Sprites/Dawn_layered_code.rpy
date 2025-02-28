init offset = -1
###########################

## Hello!
## Please follow the instructions on the lines preceeded by a single hashtag (#) to configure this sprite for use! (1st one in Character section and 2nd one in Layered Image section)
## Changes to make: 1), 2). 

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
image Dawn_face_normal:
    "Dawn/Dawn_face_normal.png"
    blinkwait
    "Dawn/Dawn_face_normal_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_face_normal.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn_face_normal2:
    "Dawn/Dawn_face_normal2.png"
    blinkwait
    "Dawn/Dawn_face_normal2_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_face_normal2.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn_face_lookaway:
    "Dawn/Dawn_face_lookaway.png"
    blinkwait
    "Dawn/Dawn_face_lookaway_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_face_lookaway.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn_face_pout:
    "Dawn/Dawn_face_pout.png"
    blinkwait
    "Dawn/Dawn_face_pout_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_face_pout.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn_face_surprised:
    "Dawn/Dawn_face_surprised.png"
    blinkwait
    "Dawn/Dawn_face_surprised_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_face_surprised.png" with Dissolve(0.2)
    0.1
    repeat

image Dawn_face_smile:
    "Dawn/Dawn_face_smile.png"
    blinkwait
    "Dawn/Dawn_face_smile_blink.png" with Dissolve(0.2)
    0.3
    "Dawn/Dawn_face_smile.png" with Dissolve(0.2)
    0.1
    repeat

###### Layered Image Script ########################
layeredimage Dawn: # 2) Change 'Dawn' on this line to your character's name!
    always:
        "Dawn/Dawn_body.png"
    group face:
        attribute normal default:
            "Dawn_face_normal"
        attribute normal2:
            "Dawn_face_normal2"
        attribute lookaway:
            "Dawn_face_lookaway"
        attribute smile:
            "Dawn_face_smile"
        attribute surprised:
            "Dawn_face_surprised"
        attribute pout:
            "Dawn_face_pout"

########## HOW TO USE ################################

## Expression options: normal, normal2, lookaway, smile, surprised, pout

## To change expressions, you can state it using the 'show' statement or through normal dialogue.

## Examples:

########### Show Statement #################
## show Dawn normal with Dissolve(0.2)
## show Dawn lookaway with Dissolve(0.2)--> changes the expression
############################################

########### During dialogue ################
## d normal "Blah Blah Blah" ---> Just state the expression after your character's letter symbol during dialogue.
## d lookaway "Blah Blah Blah" ---> Change the expression by stating a new one
############################################

## For more info on using layered images, please check Renpy Documentation.
## Enjoy!
