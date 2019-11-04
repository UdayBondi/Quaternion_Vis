void cameraControls(float speed, float tilesize) {

  if (keyPressed) {
    if (key == 'w') {
      pos.x -= sin(camYAng)*speed;
      pos.z += cos(camYAng)*speed;
    } else  if (key == 's') {
      pos.x += sin(camYAng)*speed;
      pos.z -= cos(camYAng)*speed;
    } else if (key == '2'){
      camXAng += 0.01;
    } else if (key == '1'){
      camXAng -= 0.01;
    } else if (key == '3'){
      camYAng += 0.01;
    } else if (key == '4'){
      camYAng -= 0.01;
    }
  }
  
  gridPos.x = pos.x%tilesize;
  gridPos.z = pos.z%tilesize;
}

void world() {
  cameraControls(15, 100);

  background(50);

  translate(width/2, height/2, 0);
  rotateX(camXAng);
  rotateY(camYAng);

  pushMatrix();
  translate(gridPos.x, gridPos.y, gridPos.z);
  rectGrid(25, 100);

  popMatrix();
  translate(pos.x, pos.y, pos.z);
}

void rectGrid(int size, int tilesize) {

  noFill();
  for (float x = -size/2; x <= size/2; x++) {
    for (float z = -size/2; z <= size/2; z++) {
      pushMatrix();

      stroke(0, 255, 0, map(dist(-gridPos.x, -gridPos.z, x*tilesize, z*tilesize), 0, size/2*tilesize, 255, 0));

      translate(x*tilesize, 0, z*tilesize);
      rotateX(HALF_PI);
      rect(0, 0, tilesize, tilesize);
      popMatrix();
    }
  }
}