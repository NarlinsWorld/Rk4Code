
class Car {
  PVector coordinates;
  PVector velocity;
  PVector acceleration;
  float accel;
  float topspeed;
  color c;
  float alpha=0;
  float angle;
  PShape s;  // The PShape object
  float speed=0;
  
  
  
  //constructor
  Car(color tempC, PVector tempCoordinates, float tempTopspeed) {
    c=tempC;
    coordinates=tempCoordinates;
    topspeed=tempTopspeed;
    velocity= new PVector(0.001,0.001);
    acceleration = new PVector(0.001,0.001);
    
    // Creating a custom PShape as a Car, by
  // specifying a series of vertices.
  s = createShape();
  s.beginShape();
  s.fill(0, 0, 255);
  s.stroke(1);
  s.vertex(-50, 10);
  s.vertex(-10, 10);
  s.vertex(0, 0);
  s.vertex(-10, -10);
  s.vertex(-50,-10);
  s.endShape(CLOSE);
  }
  
  void update(){
    checkKey1();
    println("vel.x=",velocity.x,"vel.y=",velocity.y,"speed=",velocity.mag());
    
    velocity.add(acceleration);
    coordinates.add(velocity);
    velocity.limit(topspeed);  
}

void display(){
  angle = atan2(velocity.y,velocity.x);
  fill(c);
  pushMatrix();
  translate(coordinates.x,coordinates.y);
  rotate(angle);
  shape(s,0,0);   
  popMatrix();
   
} //end display()

void checkEdges() {
  if(coordinates.x>width){
    coordinates.x=0;
  } else if(coordinates.x<0){
    coordinates.x=width;
  }
  
  if(coordinates.y>height){
    coordinates.y=0;
  } else if(coordinates.y<0){
    coordinates.y=height;
  }
  
  }
  
  void checkKey1(){
    //key=0;
    if (keyPressed) {
      if (key == 'u' || key == 'U' || keyCode == UP) {
        c=color(0,255,0); //Green        
        acceleration.set(1.01*velocity.x-velocity.x,1.01*velocity.y-velocity.y); //<>//
        
        if(velocity.mag()<0.09){
          float den = 10*pow(velocity.x,2) + 10*pow(velocity.y,2);
          float ax = (-10*pow(velocity.x,3)-10*velocity.x*pow(velocity.y,2)+velocity.x*sqrt(pow(velocity.x,2)+pow(velocity.y,2)))/den;
          float ay = (-10*pow(velocity.x,2)*velocity.y -10*pow(velocity.y,3)+velocity.y*sqrt(pow(velocity.x,2)+pow(velocity.y,2)))/den;
          acceleration.set(ax,ay);
          } //end if
        
      } // end if key is UP accelerate.
    
    
    
      if (key =='d' || key =='D' || keyCode == DOWN) {
        c=color(255,0,0);  //Red for braking          
        //angle = atan2(velocity.y,velocity.x);
        acceleration.set(0.99*velocity.x-velocity.x,0.99*velocity.y-velocity.y);
        
        } //end if key is go down
        
     if(key == 's' || key =='S'){
      acceleration.set(0,0);
      //velocity.set(0,0);
    } //END if s then stop
    
    if (key == CODED) {
        if (keyCode == RIGHT) { //clockwise
         /* alpha = alpha+1;
          speed = velocity.mag();
          velocity.set(cos(alpha*PI/180)*speed,sin(alpha*PI/180)*speed); */
          
          alpha = atan2(velocity.y,velocity.x); //current heading
          if(velocity.mag() < 0.5){ //use 1 degree of turn per button push
          acceleration.set(cos((180*alpha+PI)/180)-cos(alpha),sin((180*alpha+PI)/180)-sin(alpha));
          }
          if(velocity.mag() > 0.5){ //use 2 degree of turn per button push
            acceleration.set(cos((90*alpha+PI)/90)-cos(alpha),sin((90*alpha+PI)/90)-sin(alpha));
          }
          if(velocity.mag() > 1.0){ //use 3 degree of turn per button push
            acceleration.set(cos((60*alpha+PI)/60)-cos(alpha),sin((60*alpha+PI)/60)-sin(alpha));
          }
          if(velocity.mag() > 2.0){ //use 5 degree of turn per button push
            acceleration.set(cos((36*alpha+PI)/36)-cos(alpha),sin((36*alpha+PI)/36)-sin(alpha));
          }
        } //end key RIGHT
        else if (keyCode == LEFT) { //counterclock
          /* alpha = alpha-1;
           speed = velocity.mag();
          velocity.set(cos(alpha*PI/180)*speed,sin(alpha*PI/180)*speed); */
          alpha = atan2(velocity.y,velocity.x); //current heading
          if(velocity.mag() < 0.5){ //use 1 degree of turn per button push
          acceleration.set(cos((180*alpha-PI)/180)-cos(alpha),sin((180*alpha-PI)/180)-sin(alpha));
          }
          if(velocity.mag() > 0.5){ //use 2 degree of turn per button push
            acceleration.set(cos((90*alpha-PI)/90)-cos(alpha),sin((90*alpha-PI)/90)-sin(alpha));
          }
          if(velocity.mag() > 1.0){ //use 3 degree of turn per button push
            acceleration.set(cos((60*alpha-PI)/60)-cos(alpha),sin((60*alpha-PI)/60)-sin(alpha));
          }
          if(velocity.mag() > 2.0){ //use 5 degree of turn per button push
            acceleration.set(cos((36*alpha-PI)/36)-cos(alpha),sin((36*alpha-PI)/36)-sin(alpha));
          }
        } //end key LEFT
      
      } //end key is CODED
 
   } //end if keyPressed
    
    if(!keyPressed) {
      c=color(0,0,255); //Blue for cruising
      acceleration.set(0,0); //so don't accelerate
    }
    
  
  if(abs(alpha) > 359){
    alpha = abs(alpha)%360;
  } //end if for alpha out of bounds
  
  } //end function checkKey1
  

} //end class
