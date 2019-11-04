Human_3D
========

A 3D model of a human made in processing. You can move around it freely, and you can control all of it's joints.

Controls
-------
press t to show or hide controls.


press w to move the camera forward

press s to move the camera backward

move mouse up and down to tilt the camera

move mouse from side to side to rotate the camera


press space to cycle through the joints

press up arrow key to increase the angle of the joint you are controling

press down arrow key to decrease the angle of the joint you are controling

press left arrow key to go to maximum angle

press right arrow key to go to minimum angle

press shift to save all current angles to the file savedAngles.txt

press L to load all saved angles from savedAngles.txt

press the mouse buttom to set all joints to a random angle


The Human
---------
the human is made of 12 different PShapes, some displayed multible times in different location. They are all created in the program, they are based on a lot of variables, for example the height of the human, the torso to height ration, the shoulderwidth to height ratio and so on.The PShapes are moved around, rotated, and displayed by a class -- that i for some reason named taillessMonkey.

The Humans Joints
------------
the angles of the different joints, is controlled by a class called joint. each joint object keeps track of the angle around one axis. There is in total 33 of these joint on one human. the reason i made them, was because i wanted the joints to work kind of like servos do in Ardoino. They shall move towards a target angle, with a certain angular velocity, when told to via a write(float,float) command. Rather than instantly moving there.

NB
-----
a lot of things has been changed since i made it first, forexample the 3D figure was originally drawn on an separete PGraphic, so that the text wouldn't be displayed behind the figure. Until litterally seconds before i would have uploaded it, when i was told at the processing forum, that i should rather use hint(DISABLE_DEPTH_TEST) and  hint(ENABLE_DEPTH_TEST) when drawing the text. It turned out to be a lot better -- especially for the framerate. I tried to remove all comments talking about different PGraphics, since the different PGraphichs isn't there anymore, but i can't promise that you wont find any outdated comments.
