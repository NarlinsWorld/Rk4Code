/* This creates a car object and the instance is named Dan. As
Dan moves along the screen, he can be speeded up with the 'U' or 'u' key.
He can be slowed with the 'd' or 'D' key.
Releasing the key will get constant velocity.
'S' or 's' will stop him.  It is best to not use this.

Sometimes, the keypresses are not registered.  I haven't got that yet.
*/
Car Dan; //declare a Car
//color c;
//PVector coordinates;
//float topspeed;

void setup(){
  size(800,800);
  Dan = new Car(color(255,0,0), new PVector(50,50), 10);
}

void draw() {
  background(255);
  Dan.update();
  Dan.checkEdges();
  Dan.display();
}
