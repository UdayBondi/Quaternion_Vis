class taillessMonkey {

  joint[] aJoint;

  PVector humanPos, humanAngles;

  float Height;

  float headHeight, heightOfHead;
  PShape head;
  float throat;

  float torsoHeight, heightOfTorso;
  PShape torso;

  PShape foot;

  float upperLegHeight, upperLegXPos;
  PShape upperLeg;

  float lowerLegHeight;
  PShape lowerLeg;

  float upperArmHeight, upperArmXPos;
  PShape upperArm;

  float lowerArmHeight;
  PShape lowerArm;

  float heightOfHand;
  PShape hand;

  float fingerHeight, fingerRadius;
  PShape fingerPart;

  int controlCycle;
  boolean clicked;

  taillessMonkey(PVector tempPos, float tempHeight, float headToHeight, float headRadiusToHeight, float eyeOfCenterAng, float torsoToHeight, float shoulderWidthToHeight, float torsoWidthLowToHeight, float torsoWidthMiddleToHeight, float fatnessLowToHeight, float fatnessMiddleToHeight, float fatnessHighToHeight, float throatToHeight, float upperLegLowWidthToHeight, float upperLegMiddleWidthToHeight, float upperLegTopWidthToHeight, float lowerLegLowWidthToHeight, float lowerLegMiddleWidthToHeight, float lowerLegTopWidthToHeight, float upperArmLowWidthToHeight, float upperArmMiddleWidthToHeight, float upperArmTopWidthToHeight, float lowerArmLowWidthToHeight, float lowerArmMiddleWidthToHeight, float lowerArmTopWidthToHeight, float handHeightToHeight, float handWidthToHeight, float handLengthToHeight, float feetHeightToHeight, float feetLengthToHeight, float feetWidthToHeight) {//that is a lot of variables
    controlCycle = 0;

    Height = tempHeight;
    humanPos = tempPos;
    humanAngles = new PVector(0, 0, 0);

    throat = throatToHeight*Height;

    headHeight = headToHeight*tempHeight;
    float headRadius = headRadiusToHeight*Height;
    heightOfHead = Height-headHeight;
    head = headShape(headHeight, headRadius);

    torsoHeight = torsoToHeight*Height;
    float shoulderWidth = shoulderWidthToHeight*Height;
    float torsoWidthLow = torsoWidthLowToHeight*Height;
    float torsoWidthMiddle = torsoWidthMiddleToHeight*Height;
    float fatnessLow = fatnessLowToHeight*Height;
    float fatnessMiddle = fatnessMiddleToHeight*Height;
    float fatnessHigh = fatnessHighToHeight*Height;
    heightOfTorso =  -(heightOfHead-torsoHeight-throat);
    torso = torsoShape(torsoHeight, torsoWidthLow, torsoWidthMiddle, shoulderWidth, fatnessLow, fatnessMiddle, fatnessHigh);

    float legLength = Height-headHeight-throat-torsoHeight;

    float handHeight = handHeightToHeight*Height;

    float feetHeight = feetHeightToHeight*Height;

    float upperLegLowWidth = upperLegLowWidthToHeight*Height;
    float upperLegMiddleWidth = upperLegMiddleWidthToHeight*Height;
    float upperLegTopWidth = upperLegTopWidthToHeight*Height;
    upperLegHeight = -(heightOfHead-torsoHeight-throat);
    upperLegXPos = torsoWidthLow/2;
    upperLeg = legOrArmShape((legLength-feetHeight)/2, upperLegLowWidth, upperLegMiddleWidth, upperLegTopWidth);

    float lowerLegLowWidth = lowerLegLowWidthToHeight*Height;
    float lowerLegMiddleWidth = lowerLegMiddleWidthToHeight*Height;
    float lowerLegTopWidth = lowerLegTopWidthToHeight*Height;
    lowerLegHeight = (legLength-feetHeight)/2;
    lowerLeg = legOrArmShape((legLength-feetHeight)/2, lowerLegLowWidth, lowerLegMiddleWidth, lowerLegTopWidth);


    float armLength = (Height-shoulderWidth)/2;

    float upperArmLowWidth = upperArmLowWidthToHeight*Height;
    float upperArmMiddleWidth = upperArmMiddleWidthToHeight*Height;
    float upperArmTopWidth = upperArmTopWidthToHeight*Height;
    upperArmHeight = -(heightOfHead-throat-torsoHeight/8);
    upperArmXPos = torsoWidthLow+upperArmTopWidth;
    upperArm = legOrArmShape((armLength-handHeight)/2, upperArmLowWidth, upperArmMiddleWidth, upperArmTopWidth);

    float lowerArmLowWidth = lowerArmLowWidthToHeight*Height;
    float lowerArmMiddleWidth = lowerArmMiddleWidthToHeight*Height;
    float lowerArmTopWidth = lowerArmTopWidthToHeight*Height;
    lowerArmHeight = (armLength-handHeight)/2;
    lowerArm = legOrArmShape((armLength-handHeight)/2, lowerArmLowWidth, lowerArmMiddleWidth, lowerArmTopWidth);

    float handLength = handLengthToHeight*Height;
    float handWidth = handWidthToHeight*Height;
    heightOfHand = lowerArmHeight;

    hand = uniteLayers(flatTopCone(handHeight/2, lowerArmLowWidth, lowerArmLowWidth, handWidth, handLength, 0));

    float feetLength = feetLengthToHeight*Height;
    float feetWidth = feetWidthToHeight*Height;
    foot = footShape(feetWidth, feetLength, feetHeight, lowerLegLowWidth);

    fingerHeight = handHeight/6;
    fingerPart = fingerShape(fingerHeight, handLength, handWidth);

    aJoint = new joint[30];

    aJoint[0] = new joint(0, -HALF_PI, HALF_PI, 0.2, "head to neck y");
    aJoint[1] = new joint(0, -HALF_PI/3, HALF_PI/3, 0.2, "head to neck x");
    aJoint[2] = new joint(0, -HALF_PI, HALF_PI/3, 0.2, "right arm to shoulder x");
    aJoint[3] = new joint(0, -HALF_PI, HALF_PI/3, 0.2, "left arm to shoulder x");
    aJoint[4] = new joint(0, -PI, HALF_PI/3, 0.2, "right arm to shoulder z");
    aJoint[5] = new joint(0, -HALF_PI/3, PI, 0.2, "left arm to shoulder z");
    aJoint[6] = new joint(0, -HALF_PI, HALF_PI, 0.2, "right arm to shoulder y");
    aJoint[7] = new joint(0, -HALF_PI, HALF_PI, 0.2, "left arm to shoulder y");
    aJoint[8] = new joint(0, -HALF_PI*3/2, 0, 0.2, "right arm joint x");
    aJoint[9] = new joint(0, -HALF_PI*3/2, 0, 0.2, "left arm joint x");
    aJoint[10] = new joint(0, -HALF_PI, HALF_PI, 0.2, "right hand joint y");
    aJoint[11] = new joint(0, -HALF_PI, HALF_PI, 0.2, "left hand joint y");
    aJoint[12] = new joint(0, -HALF_PI/2, HALF_PI, 0.2, "right hand joint z");
    aJoint[13] = new joint(0, -HALF_PI, HALF_PI/2, 0.2, "left hand joint z");
    aJoint[14] = new joint(HALF_PI, 0, HALF_PI, 0.2, "right hand finger part 1 joint z");
    aJoint[15] = new joint(-HALF_PI, -HALF_PI, 0, 0.2, "left hand finger part 1 joint z");
    aJoint[16] = new joint(HALF_PI, 0, HALF_PI, 0.2, "right hand finger part 2 joint z");
    aJoint[17] = new joint(-HALF_PI, -HALF_PI, 0, 0.2, "left hand finger part 2 joint z");
    aJoint[18] = new joint(HALF_PI, 0, HALF_PI, 0.2, "right hand finger part 3 joint z");
    aJoint[19] = new joint(-HALF_PI, -HALF_PI, 0, 0.2, "left hand finger part 3 joint z");
    aJoint[20] = new joint(0, -PI*0.9, 0, 0.2, "right leg to torso joint x");
    aJoint[21] = new joint(0, -PI*0.9, 0, 0.2, "left leg to torso joint x");
    aJoint[22] = new joint(0, -HALF_PI/2, 0, 0.2, "right leg to torso joint z");
    aJoint[23] = new joint(0, 0, HALF_PI/2, 0.2, "left leg to torso joint z");
    aJoint[24] = new joint(0, 0, PI*0.9, 0.2, "right leg joint x");
    aJoint[25] = new joint(0, 0, PI*0.9, 0.2, "left leg joint x");
    aJoint[26] = new joint(0, -HALF_PI/2, HALF_PI/3, 0.2, "right foot joint x");
    aJoint[27] = new joint(0, -HALF_PI/2, HALF_PI/3, 0.2, "left foot joint x");
    aJoint[28] = new joint(0, -HALF_PI/2, HALF_PI/2, 0.2, "right foot joint y");
    aJoint[29] = new joint(0, -HALF_PI/2, HALF_PI/2, 0.2, "left foot joint y");
  }

  void be() {
    pushMatrix();

    sphere(1000);

    displayHead();
    displayTorso();
    displayLeg(upperLegXPos, 0);
    displayLeg(-upperLegXPos, 1);
    displayArm(upperArmXPos, 0);
    displayArm(-upperArmXPos, 1);

    popMatrix();

    updateJoints();
  }

  void displayHead() {
    pushMatrix();

    translate(0, -heightOfHead, 0);

    rotateY(aJoint[0].ang);    
    rotateX(aJoint[1].ang);

    shape(head);
    
    popMatrix();
  }

  void displayTorso() {
    pushMatrix();
    translate(0, heightOfTorso, 0);
    shape(torso);
    popMatrix();
  }

  void displayLeg(float xPos, int i) {
    pushMatrix();
    translate(xPos, upperLegHeight, 0);

    rotateX(aJoint[20+i].ang);

    rotateZ(aJoint[22+i].ang);

    shape(upperLeg);

      translate(0, lowerLegHeight, 0);

    rotateX(aJoint[24+i].ang);

    shape(lowerLeg);

      translate(0, lowerLegHeight, 0);

    rotateY(aJoint[28+i].ang);
    rotateX(aJoint[26+i].ang);

    shape(foot);


    popMatrix();
  }

  void displayArm(float xPos, int i) {
    pushMatrix();

    translate(xPos, upperArmHeight, 0);
    rotateZ(aJoint[4+i].ang);
    rotateX(aJoint[2+i].ang);
    rotateY(aJoint[6+i].ang);

    shape(upperArm);


    translate(0, lowerArmHeight, 0);

    rotateX(aJoint[8+i].ang);

    shape(lowerArm);

    translate(0, heightOfHand, 0);

    rotateY(aJoint[10+i].ang);
    rotateZ(aJoint[12+i].ang);

    shape(hand);

    translate(0, fingerHeight*3, 0);

    rotateZ(aJoint[14+i].ang);

    shape(fingerPart);

    translate(0, fingerHeight, 0);

    rotateZ(aJoint[16+i].ang);

    shape(fingerPart);

    translate(0, fingerHeight, 0);

    rotateZ(aJoint[18+i].ang);

    shape(fingerPart);

    popMatrix();
  }

  void userControl() {
    if (keyPressed) {
      if (key == ' ' && !clicked) {
        controlCycle++;
        controlCycle = controlCycle%aJoint.length;
        clicked = true;
      }
    } else { 
      clicked = false;
    }
    if (showText) {
    displayInfo();
    }
    
    if(mousePressed){
      aJoint[controlCycle].write(map(mouseX,0,width,aJoint[controlCycle].minAng,aJoint[controlCycle].maxAng), aJoint[controlCycle].maxV);
    }
  }


  void updateJoints() {
    for (int i = 0; i < aJoint.length; i++) {
      aJoint[i].update();
    }
  }

  void saveJoints() {
    String[] angles = new String[aJoint.length*2];

    for (int i = 0; i < aJoint.length; i++) {
      angles[i*2] = aJoint[i].name;
      angles[i*2+1] = ""+aJoint[i].ang;
    }

    saveStrings("Data/savedAngles.txt", angles);
  }
  
  void loadJoints(){
        String[] angles = loadStrings("savedAngles.txt");
        for (int i = 0; i < aJoint.length; i++) {
          aJoint[i].write(float(angles[i*2+1]), aJoint[i].maxV);
        }
  }
  
  void displayInfo(){

    fill(255, 0, 0);
    textAlign(LEFT);
    
    text("STATUS OF JOINT:", 5, 10);
    text("active:  "+ aJoint[controlCycle].active(), 5, 25);
    text("current angle:  "+ int(degrees(aJoint[controlCycle].ang))+"°", 5, 40);
    text("target angle:  "+ int(degrees(aJoint[controlCycle].targAng))+"°", 5, 55);
    text("minimum angle: "+ int(degrees(aJoint[controlCycle].minAng))+"°", 5, 70);
    text("maximum angle: "+ int(degrees(aJoint[controlCycle].maxAng))+"°", 5, 85);
    text("joint name: "+ aJoint[controlCycle].name, 5, 100);

    text("JOINT CONTROLS:", 5, height-115);
    text("go to maximum anlge: arrow key left", 5, height-100);
    text("go to minimum anlge: arrow key right", 5, height-85);
    text("increase angle by 1: arrow key up", 5, height-70);
    text("decrease angle by 1: arrow key down", 5, height-55);
    text("set all joints to angle: mouse button", 5, height-40);
    text("SAVE: shift", 5, height-25);
    text("LOAD: L", 5, height-10);
  }
}