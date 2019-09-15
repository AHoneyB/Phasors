Wave w;

void setup(){
  size(1200,800);
  
  w = new Wave(100,100,30,1,1); // (px,py) amp,k,w
  //frameRate(5);
}

void draw(){
   background(230);
   w.render();
}
