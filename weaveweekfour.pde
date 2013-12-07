int dimVar = 176; // Change this int to specify tightness of weave. 
Thread[] threads= new Thread[4];
Cross overCross = new Cross(true, dimVar);
Cross underCross = new Cross(false, dimVar);

void setup() {
  size(500, 500);
  background(0);
  //frameRate(10);
  threads[0] = new Thread(dimVar, true, true); //Slow Horizontal
  threads[1] = new Thread(dimVar, true, false); // Slow Vertical
  threads[2] = new Thread(dimVar, false, true); //Fast Horizontal
  threads[3] = new Thread(dimVar, false, false); //Fast Vertical
}

void draw() {
 
 
  /* hard coding the weave. Ouch. 
  
   overCross.draw();
   pushMatrix();
   translate(0, 200);
   underCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(0, 400);
   overCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(0, 600);
   underCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(0, 800);
   overCross.draw();
   popMatrix();
   //-----column 2  
   pushMatrix();
   translate(200, 0);
   underCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(200, 200);
   overCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(200, 400);
   underCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(200, 600);
   overCross.draw();
   popMatrix();
   
   //--column3
   pushMatrix();
   translate(400, 0);
   overCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(400, 200);
   underCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(400, 400);
   overCross.draw();
   popMatrix();
   
   pushMatrix();
   translate(400, 600);
   underCross.draw();
   popMatrix();
   */

// the tiling logic, alternating over and under passes for rows and columns
// next, work on a twill pattern


  for (int i = 0; i < 800; i = i + dimVar) { //replaced width with 600, change back later
    for (int j = 0; j < 800; j = j + dimVar) {
      //println(i + "," + j);
      pushMatrix();
      translate( i, j);
      if ( j % (2 * dimVar) == 0) {

        if ( i % (2 * dimVar) == 0) {
          overCross.draw();
          popMatrix();
        }
        else {
          underCross.draw();
          popMatrix();
        }
      }else{
        if ( i % (2 * dimVar) == 0) {
          underCross.draw();
          popMatrix();
        }
        else {
          overCross.draw();
          popMatrix();
        }
      }
    }
  }
}


class Cross {
  boolean over = true;
  float dimVar;
  // boolean under = !over;

  Cross(boolean over, float dimVar) {
    this.over = over;
    this.dimVar = dimVar;
    // this.under = !this.over;
  }

  void draw() {
    if (this.over) {
      threads[0].draw();
      threads[3].draw();
    }
    else {
      threads[2].draw();
      threads[1].draw();
    }
  }
}

class Thread {
  boolean slow = true;
  boolean fast = !slow; //look this shit up.
  boolean horizontal = true;
  boolean vertical = !horizontal;
  float dimVar;
  float speedSlow = .1;
  float speedFast = .2;
  float pos = 0;

  Thread(float dimVar, boolean slow, boolean horizontal) {
    this.dimVar = dimVar;
    this.slow = slow;
    this.fast = !slow;
    this.vertical = !horizontal;
    this.horizontal = horizontal;
    this.pos = 0;
  }

  void draw() {
    if (this.horizontal && this.slow && this.pos < dimVar) {
      fill(255, 0, 0); 
      noStroke();
      rectMode(CENTER);
      rect(pos, dimVar/2, 20, 20);
      this.pos = this.pos + speedSlow;
    }
    else if (this.horizontal && this.fast && this.pos < dimVar) {
      fill( 255, 0, 0); 
      noStroke();
      rectMode(CENTER);
      rect(pos, dimVar/2, 20, 20);
      this.pos = this.pos + speedFast;
    }
    else if (this.vertical && this.slow && this.pos < dimVar) {
      fill( 0, 0, 255); 
      rectMode(CENTER);
      rect(dimVar/2, pos, 20, 20);
      this.pos = this.pos + speedSlow;
    }
    else if (this.vertical && this.fast && this.pos < dimVar) {
      fill(0, 0, 255); 
      rectMode(CENTER);
      rect(dimVar/2, pos, 20, 20);
      this.pos = this.pos + speedFast;
    }
  }
}
