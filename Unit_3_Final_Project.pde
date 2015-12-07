import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

Drawing Tri;

//varibles
float lx = 20;
float ly = 20;
float rx = 50;
float ry = 50;
color BLUE = color (0, 0, 255);
color WHITE = color (255);
color GREY = color (84);
PImage triangles;

//init the kinect and the tracker
Kinect kinect;
ArrayList <SkeletonData> bodies;

void setup()
{

  fullScreen();
  triangles=createImage(width, height, ARGB);
  background(0);
  Tri = new Drawing();
  kinect = new Kinect(this);
  fill (255);
  smooth();
  bodies = new ArrayList<SkeletonData>();
}

void draw()
{
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
  }
  Tri.Setpos(lx, ly, rx, ry);
  Tri.Draw();
  image(kinect.GetDepth(), width-320, height-240, 320, 240 ); 
  loadPixels();
  triangles.loadPixels();
  for ( int i =0; i<pixels.length; i++)
  {
    if (pixels[i] == BLUE)
    {
      triangles.pixels[i] = BLUE;
    } 
    else if(pixels[i] == WHITE)
    {
      triangles.pixels[i] = WHITE;
    }
    else if(pixels[i] == GREY)
    {
      triangles.pixels[i] = GREY;
    } 
    else
    {
      triangles.pixels[i] = color(0, 0, 0, 0);
    }
  }
  triangles.updatePixels();
  background(0);
  image(triangles, 0, 0);
  Tri.Setpos(lx, ly, rx, ry);
  Tri.Draw();
  fill(255, 0, 0);
  ellipse(rx, ry, 50, 50);
  ellipse(lx, ly, 50, 50);
/*  if (rx>=lx+15 || rx<=lx+15)
  {
   if (ry>=ly+15 || ry<=ly+15)
   {
     background(0);
   }
  }
  */
}



void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(255);
}

void drawSkeleton(SkeletonData _s) 
{
  //left hand 
  DrawHand(_s, Kinect.NUI_SKELETON_POSITION_HAND_LEFT, 1);
  //right hand
  DrawHand(_s, Kinect.NUI_SKELETON_POSITION_HAND_RIGHT, 0);
}

void DrawHand(SkeletonData _s, int _hand, int h)
{
  if (_s.skeletonPositionTrackingState[_hand] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED)
  {

    if (h==1)
    {
      lx= _s.skeletonPositions[_hand].x*width;
      ly= _s.skeletonPositions[_hand].y*height;
    } else
    {
      rx= _s.skeletonPositions[_hand].x*width;
      ry= _s.skeletonPositions[_hand].y*height;
    }
  }
}
//tracking
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