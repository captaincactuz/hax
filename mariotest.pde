int shipx;
int shipy;
 
int bulletx;
int bullety;

Controls controls;
Player player;
alien_class alien[];
 
class alien_class
{
  int alienx;
  int alieny;
  int alienxv;
  int alienyv;
 
  alien_class()
  {
    alienx=(int)(random(width));
    alieny=(int)(random(20));
    alienxv=(int)(random(11)); // 0 - 10
    alienxv-=5;
    alienyv=(int)(random(3));
    }
 
  void alien_update()
  {
    move_alien();
    fill(0, 255, 0);
    rect(alienx, alieny, 10, 10);
  }
 
  void move_alien()
  {
    alienx+=alienxv;
    if (alienx>width) alienxv=-alienxv;
    if (alienx<0) alienxv=-alienxv;
 
    alieny+=alienyv;
    if (alieny>height) alienyv=-alienyv;
    if (alieny<0) alienyv=-alienyv;
  }
}

class Player {
  float x, y;
  float vx, vy;
  float speed = 5;
  
  Player(float x, float y) {
   this.x = x;
   this.y = y;
   this.vx = 0;
   this.vy = 0;  
  }
  
  void update() {
    
    if(controls.w) {
      vy = -speed;
    } else if(controls.s) {
      vy = speed;
    } else {
      vy = 0; 
    }
    
    if(controls.a) {
      vx = -speed;
    } else if(controls.d) {
      vx = speed;
    } else {
      vx = 0;
    }
    
    x += vx;
    y += vy;
    
    fill(255, 255, 166);
    rect(x-5, y-5, 10, 10);
  }
  
}

class Controls {
 Boolean w, a, s, d;

  Controls() {
   w = false;
   a = false;
   s = false;
   d = false;
  }
}
 
 
void setup()
{
  size(400, 240);
  frameRate(30);
  
  controls = new Controls();
  
  player = new Player(100,100);
 
  alien = new alien_class[10];
   
  for (int i=0; i<10; i++) alien[i] = new alien_class();
   
  bulletx=-1; // if the bullets x coordinate is -1 we consider it not firing.
  shipx=width/2;
  shipy=height-20;
 
  fill(255);
  stroke(0);
}
 
void draw()
{
  background(0);
 
  fill(0, 255, 0);
  fill(255);
  rect(shipx, shipy, 10, 10);
 
  if (bulletx>0)
  {
    fill(255, 0, 0);
    rect(bulletx, bullety, 4, 4);
    bullety-=5;
    if (bullety<0) bulletx=-1;
  }
  
  player.update();
 
  for (int i=0; i<10; i++) alien[i].alien_update();
   
  move_ship();
}
 
void move_ship()
{
  if (mouseX>shipx) shipx+=5;
  if (mouseX<shipx) shipx-=5;
}
 
void keyPressed() {
  if(key == 'w') {
    controls.w = true;
  } else if(key == 'a') {
    controls.a = true;
  } else if(key == 's') {
    controls.s = true;
  } else if(key == 'd') {
    controls.d = true;
  }
}

void keyReleased() {
  if(key == 'w') {
    controls.w = false;
  } else if(key == 'a') {
    controls.a = false;
  } else if(key == 's') {
    controls.s = false;
  } else if(key == 'd') {
    controls.d = false;
  }
}
 
void mousePressed() {
  if (bulletx>=0) return; // do not fire if a bullet is already fired
  bulletx=shipx;
  bullety=shipy-5;
}

