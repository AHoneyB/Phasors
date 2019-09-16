Wave Vs,Vr,Ir;
Wave Vc,Vl;

void setup(){
  size(1200,800);
  // "name",(px,py), amp,k,w ,phase ,RGB
  float Vps = 60;
  float R = 5, Xc = 10, Xl = 20, Z=(float)Math.sqrt( (Xl-Xc)*(Xl-Xc) + R*R);
  float Ips = Vps/Z;
   float yPos = 60;
  float phasrVs = -atan2((Xl-Xc),R);
  //float phasrVs = atan2((Xl-Xc),R);
  


  yPos += 2.2*Vps;
  Vs = new Wave("Supply voltage",60,      yPos,        Vps,1,1,phasrVs,255,0,0); 
   Ir = new Wave("Supply current",60+550, yPos,       Ips,1,1,0,255,0,0);
  float   Ipr = Ips, Vpr=R*Ipr;
  yPos +=2.2*Vps;
  Vr = new Wave("Resistor voltage",60,    yPos,    Vpr,1,1,0,125,64,125); 
  
  float  Vpc =Xc *Ips ;
  yPos +=2.5*Vps;
  Vc = new Wave("Capacitor voltage",60,   yPos,    Vpc,1,1,+HALF_PI,0,125,125); 
  float  Vpl =Xl *Ips ;
  yPos +=3*Vps;
  Vl = new Wave("Inductor voltage",60,   yPos,    Vpl,1,1,-HALF_PI,125,125,0); 
  frameRate(20);
  
  println("Vs= "+Vps+" V");  
  println("Z= "+Z+" ohm");
  println("Is= "+Ips+" A");
  println("Vr= "+Vpr+" V");
  println("Vc= "+Vpc+" V");
  println("Vl= "+Vpl+" V");
}

void draw(){
   background(230);
   Vs.render();
   Vr.render();
   Ir.render();
   Vc.render();
   Vl.render();
   
   //Vs.renderOnlyPhasor();
   //Vr.renderOnlyPhasor();
   //Vc.renderOnlyPhasor();
   //Vl.renderOnlyPhasor();
}
