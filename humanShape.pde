PShape headShape(float Height, float radius) {
  PShape head = createShape(GROUP);

  float bottomHeadHeight = Height/2;
  float bottomHeadTopWidth = radius*0.9;
  float bottomHeadTopLength = radius;
  float bottomHeadBottomWidth = radius/3*2*0.9;
  float bottomHeadBottomLength = radius/3*2;
  float heightOfBottomHead = Height/2;

  head.addChild(uniteLayers(flatTopCone(bottomHeadHeight, bottomHeadTopWidth, bottomHeadTopLength, bottomHeadBottomWidth, bottomHeadBottomLength, heightOfBottomHead)));

  float topOfHeadHeightRadius = Height/2;
  float topOfHeadWidthRadius = radius*0.9;
  float topOfHeadLengthRadius = radius;
  float heighOfTopOfHead = -Height/2;

  head.addChild(uniteLayers(halfEllipsoidLayers(topOfHeadWidthRadius, topOfHeadHeightRadius, topOfHeadLengthRadius, heighOfTopOfHead)));

  return  head;
}


PShape  torsoShape(float Height, float lowWidth, float middleWidth, float shoulderWidth, float fatnessLow, float fatnessMiddle, float fatnessHigh) {
  PShape torso = createShape(GROUP);

  float lowTorsoHeight = Height/8*3;
  float heightOflowTorso = Height/2;

  torso.addChild(uniteLayers(flatTopCone(lowTorsoHeight, middleWidth, fatnessMiddle, lowWidth, fatnessLow, heightOflowTorso)));

  float topTorsoHeight = Height/8*3;
  float heightOftopTorso = Height/8*7;

  torso.addChild(uniteLayers(flatTopCone(topTorsoHeight, shoulderWidth, fatnessHigh, middleWidth, fatnessMiddle, heightOftopTorso)));


  float shoulderHeight = (Height)/8;
  float heightOfShoulder = -(Height)/8*7;

  torso.addChild(uniteLayers(halfCyllinderLayers(shoulderWidth, shoulderHeight, fatnessHigh, heightOfShoulder)));

  float bottomHeight = -(Height)/8;
  float heightOfBottom = -(Height)/8;

  torso.addChild(uniteLayers(halfEllipsoidLayers(lowWidth, bottomHeight, fatnessLow, heightOfBottom)));

  return torso;
}


PShape legOrArmShape(float Height, float lowRadius, float middleRadius, float highRadius) {
  PShape legOrArm = createShape(GROUP);
  
  
  
  float lowPartHeight = Height/2;
  float HeightOfLowPart = -Height/2;
  
  legOrArm.addChild(uniteLayers(flatTopCone(lowPartHeight, middleRadius, middleRadius, lowRadius, lowRadius, HeightOfLowPart)));


  float topPartHeight = Height/2;
  float HeightOfTopPart = 0;
  
  legOrArm.addChild(uniteLayers(flatTopCone(topPartHeight, highRadius, highRadius, middleRadius, middleRadius, HeightOfTopPart)));


  float conectionHeight = -Height/8;
  float heightOfConection = Height;

  legOrArm.addChild(uniteLayers(halfEllipsoidLayers(lowRadius, conectionHeight, lowRadius, heightOfConection)));
  legOrArm.addChild(uniteLayers(halfEllipsoidLayers(highRadius, -conectionHeight, highRadius, 0)));

  return legOrArm;
}


PShape fingerShape(float Height, float Length, float Width){
  PShape finger = createShape(GROUP);
  
  finger.addChild(uniteLayers(flatTopCone(Height, Width, Length, Width, Length, 0)));
  finger.addChild(uniteLayers(halfEllipsoidLayers(Width, -Height/2, Length, Height)));

  return finger;
}

PShape footShape(float Width,float Length,float Height, float legWidth){
  PShape foot = createShape(GROUP);
  
  foot.addChild(uniteLayers(flatTopCone(Height, legWidth, legWidth, Width, Width, 0)));

  PShape[] layer;
  layer = new PShape[6];


  for (int i = 0; i < layer.length; i++) {//i goes from 0,  90 degrees

    float thisLayerHeight = sin(radians(i*20+180))*Height/2+Height;//the specific height
    float thisLayerRadiusWidth = cos(radians(i*20+180))*Width;//the specific width
    float thisLayerRadiusLength = cos(radians(i*20+180))*Length;//the specific length

    layer[i] = createShape();
    layer[i].beginShape();

    for (int j = 0; j <= 360; j+=30) {//j goes from 0 to 360 degrees
      layer[i].vertex(thisLayerRadiusWidth*cos(radians(j)), thisLayerHeight, thisLayerRadiusLength*sin(radians(j))-Length/2);
    }  
    layer[i].endShape();
  }
  
  foot.addChild(uniteLayers(layer));


  return foot;
}


PShape uniteLayers(PShape[] layers) {
  PShape allSides = createShape(GROUP);
  
  PShape[] side;
  side = new PShape[layers.length-1];

  for (int i = 0; i < side.length; i++) {
    side[i] = createShape();

    side[i].beginShape(QUAD_STRIP);
    
    for (int n = 0; n < layers[0].getVertexCount (); n++) {

      PVector v_1 = layers[i].getVertex(n);
      PVector v_2 = layers[i+1].getVertex(n);
      PVector v_3 = layers[i].getVertex((n+1)%layers[0].getVertexCount());
      PVector v_4 = layers[i+1].getVertex((n+1)%layers[0].getVertexCount());

      side[i].vertex(v_1.x, v_1.y, v_1.z);
      side[i].vertex(v_2.x, v_2.y, v_2.z);
      side[i].vertex(v_3.x, v_3.y, v_3.z);
      side[i].vertex(v_4.x, v_4.y, v_4.z);
    }
    side[i].endShape();

    allSides.addChild(side[i]);
  }

  return allSides;
}


PShape[] halfEllipsoidLayers(float radiusX, float radiusY, float radiusZ, float Height)  {
  PShape[] layer;
  layer = new PShape[6];


  for (int i = 0; i < layer.length; i++) {

    float thisLayerHeight = sin(radians(i*20+180))*radiusY+Height;
    float thisLayerRadiusWidth = cos(radians(i*20+180))*radiusX;
    float thisLayerRadiusLength = cos(radians(i*20+180))*radiusZ;

    layer[i] = createShape();
    layer[i].beginShape();

    for (int j = 0; j <= 360; j+=30) {
      layer[i].vertex(thisLayerRadiusWidth*cos(radians(j)), thisLayerHeight, thisLayerRadiusLength*sin(radians(j)));
    }  
    layer[i].endShape();
  }
  return layer;
}

PShape[] halfCyllinderLayers(float radiusX, float radiusY, float radiusZ, float Height) {
  PShape[] layer;
  layer = new PShape[6];


  for (int i = 0; i < layer.length; i++) {

    float thisLayerHeight = sin(radians(i*20+180))*radiusY+Height;
    float thisLayerRadiusWidth = radiusX;
    float thisLayerRadiusLength = cos(radians(i*20+180))*radiusZ;

    layer[i] = createShape();
    layer[i].beginShape();

    for (int j = 0; j <= 360; j+=30) {
      layer[i].vertex(thisLayerRadiusWidth*cos(radians(j)), thisLayerHeight, thisLayerRadiusLength*sin(radians(j)));
    }  
    layer[i].endShape();
  }
  return layer;
}

PShape[] flatTopCone(float Height, float topWidth, float topLength, float bottomWidth, float bottomLength, float heightOfCone) {
  PShape[] layer;

  layer = new PShape[2];

  for (int i = 0; i < layer.length; i++) {
    layer[i] = createShape();

    layer[i].beginShape();

    float thisLayerHeight = Height/(layer.length-1)*i-heightOfCone;
    float thisLayerWidthRadius = map(i, 0, layer.length-1, topWidth, bottomWidth );
    float thisLayerLenghtRadius= map(i, 0, layer.length-1, topLength, bottomLength);

    for (float j = 0; j <= 360; j += 30) {
      layer[i].vertex(sin(radians(j))*thisLayerWidthRadius, thisLayerHeight, thisLayerLenghtRadius*cos(radians(j)));
    }
    layer[i].endShape();
  }

  return layer;
}