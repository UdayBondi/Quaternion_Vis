class joint {
  float ang;
  float maxAng, minAng;
  float targAng;
  float angV;
  float maxV;
  String name;
  
  joint(float tempAng, float tempMinAng, float tempMaxAng, float tempMaxV, String tempName) {
    angV = 0;
    ang = tempAng;
    maxAng = tempMaxAng;
    minAng = tempMinAng;
    targAng = tempAng;
    maxV = tempMaxV;
    name = tempName;
  }

  boolean active() {
    if (angV != 0) {
      return true;
    } else {
      return false;
    }
  }

  void setAng(float newAng) {

    if (newAng < minAng)  {
      ang = minAng;
    } else if (newAng > maxAng)  {
      ang = maxAng;
    } else {
      ang = newAng;
    }

    angV = 0;
  }

  void write(float newAng, float newV) {
    if (newAng != ang) {
      if (newAng < minAng) {
        newAng = minAng;
      } else if (newAng > maxAng) {
        newAng = maxAng;
      }
      
      targAng = newAng;
      
      newV = abs(newV);
      
      if (newV > maxV) {
        newV = maxV;
      }
      
      if (targAng < ang) {
        angV = -newV;
      }
      else {
        angV = newV;
      }
    }
  }
  
  void update(){
    if (active()) {
      if (abs(targAng-ang) < abs(angV)) {
        ang = targAng;
        angV = 0;
      }
      else {
        ang += angV;
      }
    }
  }
}