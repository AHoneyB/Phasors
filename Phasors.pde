import controlP5.*;

Wave Vs,  Is;
Wave Vr, Vc, Vl;
ControlP5 cp5;
Slider slider;

float w0,k0;         //angular frequency
Float R, Xc, Xl, Z;
float Vps, Ips;
float phasrVs;
float Vpr, Vpc, Vpl;
float Ipr, Ipc, Ipl;


void setup() {
  size(1200, 700);
   k0=1;
   w0 =1;
  cp5 = new ControlP5(this);
  // horizontal scroller
  slider = cp5.addSlider("w0")
     .setPosition(20,20)
     .setSize(100,20)
     .setRange(0.25,4)
     ;
   
  setCircuitValues();
  float xPos=120, yPos = 200;
   
  //yPos += 2.2*Vps;
  Vs = new Wave("Supply voltage", xPos, yPos, Vps, k0, w0, phasrVs, 255, 0, 0);  // "name",(px,py), amp,k,w ,phase ,RGB
  Is = new Wave("Supply current", xPos, yPos+200, Ips, k0, w0, 0, 255, 0, 0);
 
  //yPos +=2.2*Vps;
  Vr = new Wave("Resistor voltage", xPos, yPos, Vpr, k0, w0, 0, 255, 128, 0); 

   
  //yPos +=2.5*Vps;
  Vc = new Wave("Capacitor voltage", xPos, yPos, Vpc, k0, w0, +HALF_PI, 0, 125, 125); 
    
  //yPos +=3*Vps;
  Vl = new Wave("Inductor voltage", xPos, yPos, Vpl, k0, w0, -HALF_PI, 125, 125, 0); 
  frameRate(20);

  println("Vs= "+Vps+" V");  
  println("Z= "+Z+" ohm");
  println("Is= "+Ips+" A");
  println("Vr= "+Vpr+" V");
  println("Vc= "+Vpc+" V");
  println("Vl= "+Vpl+" V");
}

void setCircuitValues(){
 Vps = 50;
  R = 1.0; 
  Xc = 1/w0; 
  Xl = 1*w0; 
  // calulate impedence
  Z=(float)Math.sqrt( (Xl-Xc)*(Xl-Xc) + R*R);
  phasrVs = -atan2((Xl-Xc), R);
  // soruce current
  Ips = Vps/Z;
  // Calculate component impendence 
  Vpr=R*Ips;
  Vpc =Xc *Ips ;
  Vpl =Xl *Ips ;
}

void draw() {
  background(230);
  if (mousePressed) {
  //println("Pressed "+w0);
  setCircuitValues();
  Vr.setPhysicalValues(Vpr, k0, w0, 0); Vr.calcWave();
  Is.setPhysicalValues(Ips, k0, w0, 0); Is.calcWave();
  Vc.setPhysicalValues(Vpc, k0, w0, +HALF_PI); Vc.calcWave();
  Vl.setPhysicalValues(Vpl, k0, w0, -HALF_PI); Vl.calcWave();
  Vs.setPhysicalValues(Vps, k0, w0, phasrVs); Vs.calcWave();
}

  Vr.render();
  Is.render();
  Vc.render();
  Vl.render();
  Vs.render();

  //Vs.renderOnlyPhasor();
  //Vr.renderOnlyPhasor();
  //Vc.renderOnlyPhasor();
  //Vl.renderOnlyPhasor();
  
}
