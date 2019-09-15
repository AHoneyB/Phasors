// SHM class
class Wave {

  ArrayList<Complex>[] wave;
  float px, py;
  float w, k, st;
  float amp;
  float phase;
  int num;
  int time, x;


  Wave(float px, float py, float a, float k, float w) {
    this.px = px;
    this.py = py;
    this.amp = a;
    phase= HALF_PI;
    this.w=w;
    this.k=k;
    st=4;
    num = 100;
    wave = new ArrayList[3];
    for (int id=0;id<3;id++){
      wave[id] = new ArrayList<Complex>();
    }
    
    time =0;
    x =0;
    calcWave(0);
  }

  void calcWave(int id) {
    wave[id].clear();
    Float re, im;

    for (int i=0; i<num; i++) {
      float xx = map(i, 0, num, 0, TWO_PI);
      for (int j=0; j<num; j++) {
        float tt = map(j, 0, num, 0, TWO_PI);
        re = amp *  (float)(Math.cos((k*xx-w*tt+phase)));
        im = amp *  (float)(Math.sin((k*xx-w*tt+phase)));
        Complex c = new Complex(re, im);
        wave[id].add(c);
      }
    }
  }

  void render() {
    int dirc =0;
    if (time>=num) 
      time =0;

    renderPhasor(60, 60, time, 255, 0, 0);
    renderSHMform(60, 60, 255, 0, 0, dirc);
    renderPointSHM(60, 60, time, 255, 0, 0, dirc);

    time +=1;
  }

  void renderSHMform(float pX, float pY, float R, float G, float B, int dir) {
    strokeWeight(1);
    stroke(0, 50);
    if (dir==0) {   // Horizontal
      line(pX+1.5*amp, pY+amp, pX+1.5*amp, pY-amp );
      line(pX+1.5*amp, pY, pX+1.5*amp+num*st, pY );
    } else {      // Vertical
      line(pX+amp, pY+1.5*amp, pX-amp, pY+1.5*amp );
      line(pX, pY+1.5*amp, pX, pY+1.5*amp+num*st );
    }


    beginShape();
    noFill();
    stroke(R, G, B);
    strokeWeight(1);
    for (int t=0; t<num; t++) {
      if (dir==0) 
        vertex(pX+st*t+1.5*amp, pY+wave[0].get(t).im );
      else
        vertex(pX+wave[0].get(t).re, pY+st*t+1.5*amp);
    }
    endShape();
    stroke(0);
  }

  void renderPointSHM(float pX, float pY, int t, float R, float G, float B, int dir) {
    fill(R, G, B);
    stroke(R, G, B);
    if (dir==0) {
      ellipse(pX+st*t+1.5*amp, pY+wave[0].get(t).im, 5, 5);
      ellipse(pX+1.2*amp, pY+wave[0].get(t).im, 5, 5);
      line(pX+1.2*amp, pY, pX+1.2*amp, pY+wave[0].get(t).im);
    } else {
      ellipse(pX+wave[0].get(t).re, pY+st*t+1.5*amp, 5, 5);
      ellipse(pX+wave[0].get(t).re, pY+1.2*amp, 5, 5);
      line(pX, pY+1.2*amp, pX+wave[0].get(t).re, pY+1.2*amp);
    }
  }

  void renderPhasor(float centerX, float centerY, int t, float R, float G, float B) {
    float dx=wave[0].get(t).re;
    float dy=wave[0].get(t).im;  
    noFill();
    stroke(0, 50);
    strokeWeight(1);
    ellipse(centerX, centerY, 2*amp, 2*amp);
    stroke(R, G, B);
    strokeWeight(2);
    line(centerX, centerY, centerX+dx, centerY+dy);
  }
}
