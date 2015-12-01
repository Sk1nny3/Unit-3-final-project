import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
float lx = 20;
float ly = 20;
float rx = 20;
float ry = 20;
color[] c = new color[3]; 


Kinect kinect;
ArrayList <SkeletonData> bodies;

void setup()
{
 fullScreen();
 background(0);
 kinect = new Kinect(this);
 fill (255);
 smooth();
 bodies = new ArrayList<SkeletonData>();
 c[0] = color(255,255,255);
 c[1] = color(84,84,84);
 c[2] = color(0,0,255);
}


void draw()
{
 image(kinect.GetDepth(), width-320, height-240, 320, 240 );
for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
  }
  
  
  triangle(random(lx, rx), random(ly, ry), random(lx, rx), random(ly, ry), random(lx, rx), random(ly, ry));
}
 
void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width, _s.position.y*height);
}
 
void drawSkeleton(SkeletonData _s) 
{
  // Left Arm
 /* DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HAND_LEFT);*/
 DrawHand(_s, Kinect.NUI_SKELETON_POSITION_HAND_LEFT,1);
  // Right Arm
/*DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);*/
 DrawHand(_s, Kinect.NUI_SKELETON_POSITION_HAND_RIGHT,0);
}
 
void DrawHand(SkeletonData _s, int _hand, int h)
{
  if (_s.skeletonPositionTrackingState[_hand] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED)
  {
    ellipse(_s.skeletonPositions[_hand].x*width,_s.skeletonPositions[_hand].y*height,50,50);
    if (h==1)
    {
     lx= _s.skeletonPositions[_hand].x*width;
     ly= _s.skeletonPositions[_hand].y*height;
    }
    else
    {
     rx= _s.skeletonPositions[_hand].x*width;
     ry= _s.skeletonPositions[_hand].y*height;
    }
  }
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width, 
    _s.skeletonPositions[_j1].y*height, 
    _s.skeletonPositions[_j2].x*width, 
    _s.skeletonPositions[_j2].y*height);
    fill(255,0,0);
    ellipse(_s.skeletonPositions[_j1].x*width,_s.skeletonPositions[_j1].y*height,50,50);

  }
}
 
void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}
 
void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}
 
void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}