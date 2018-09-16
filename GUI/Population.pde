class Population{
  Dot [] dots; 
  float sum; 
  
  int bestDot = 0; 
  int minStep = 1000; 
  int gen = 1; 
  
  Population(int size){
    dots = new Dot[size]; 
    
    for(int i = 0; i < dots.length; i++){
      dots[i] = new Dot(); 
    }
  }
  
  void show(){
    for(int i = 0; i<dots.length; i++){
      dots[i].show(); 
    }
    dots[0].show();
  }
  
  void update(){
    for(int i = 0; i<dots.length; i++){
      if(dots[i].brain.step > minStep){
        dots[i].dead = true; 
      }else {
      dots[i].update(); 
      }
    }
  }
  
  void storeFitness(){
    for(int i = 0; i < dots.length; i++){
      dots[i].calculateFitness(); 
    }
  }
  
  boolean allDead(){
    for(int i = 0; i < dots.length; i++){
       if(!dots[i].dead && !dots[i].reachedGoal){
         return false; 
       }
    }
       return true; 
  }
  
  void naturalSelection(){
     Dot [] newDots = new Dot[dots.length];
     setBestDot();
     calculateSum(); 
     
     newDots[0] = dots[bestDot].getBaby();
     newDots[0].isBest = true; 
     
     for (int i =1; i < newDots.length; i++){
        //get parents 
        Dot parent = selectParent(); 
        //get babies 
        newDots[i] = parent.getBaby(); 
     }
     
     dots = newDots.clone(); 
     gen++; 
  }
  
  void calculateSum(){
    int sum = 0; 
    for(int i = 0; i < dots.length; i++){
      sum += dots[i].fitness; 
    }  
  }
  
  Dot selectParent(){
    float rand = random(sum);
    
    float runningSum = 0;

    for (int i = 0; i< dots.length; i++) {
      runningSum+= dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }
    return null;
  }
  
  void mutateBabies(){
    for(int i = 0; i < dots.length; i++){
       dots[i].brain.mutate();  
    }
    
  }
  
  void setBestDot(){
    float max = 0; 
    int maxIndex = 0; 
    
    for(int i = 0; i<dots.length; i++){
     if(dots[i].fitness > max){
       max = dots[i].fitness; 
       maxIndex = i; 
    } 
  }
  
  bestDot = maxIndex; 
  
  if(dots[bestDot].reachedGoal){
    minStep = dots[bestDot].brain.step; 
    println("step: ",minStep);  
  } 
  }
}