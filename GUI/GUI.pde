Population test; 
PVector goal = new PVector(400,10); 

void setup(){
 size(800,800); 
 test = new Population(1000); 
 frameRate(100); 
    
}

void draw(){
  background(255); 
  
  //draw goal 
  fill(0,255,0);
  ellipse(goal.x, goal.y,10,10); 
  
  if(test.allDead()){
     test.storeFitness(); 
     test.naturalSelection(); 
     test.mutateBabies();
  }
  else{
    test.update(); 
    test.show();
  }
}