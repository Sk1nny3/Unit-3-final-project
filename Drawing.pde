class Drawing
{
 float _lx = 0;
 float _ly = 0;
 float _rx = 0;
 float _ry = 0;
 
 Drawing()
 {
   _lx = 0;
   _ly = 0;
   _rx = 0;
   _ry = 0;
 
 }

 
 void Draw()
 {
  fill (255,255,255);
  triangle(random(_lx, _rx), random(_ly, _ry), random(_lx, _rx), random(_ly, _ry), random(_lx, _rx), random(_ly, _ry)); 
  fill (84,84,84);
  triangle(random(_lx, _rx), random(_ly, _ry), random(_lx, _rx), random(_ly, _ry), random(_lx, _rx), random(_ly, _ry)); 
  fill (0,0,255);
  triangle(random(_lx, _rx), random(_ly, _ry), random(_lx, _rx), random(_ly, _ry), random(_lx, _rx), random(_ly, _ry)); 
   
  fill (255,255,255);
  triangle(random(_rx, _lx), random(_ry, _ly), random(_rx, _lx), random(_ry, _ly), random(_rx, _lx), random(_ry, _ly)); 
  fill (84,84,84);
  triangle(random(_rx, _lx), random(_ry, _ly), random(_rx, _lx), random(_ry, _ly), random(_rx, _lx), random(_ry, _ly)); 
  fill (0,0,255);
  triangle(random(_rx, _lx), random(_ry, _ly), random(_rx, _lx), random(_ry, _ly), random(_rx, _lx), random(_ry, _ly));  
 
 }
 
 void Setpos(float lx,float ly,float rx,float ry)
 {
   _lx=lx;
   _ly=ly;
   _rx=rx;
   _ry=ry;
 }
 
  float getlx()
  {
   return _lx; 
  }
  
  float getly()
  {
   return _ly; 
  }
  
  float getrx()
  {
   return _rx; 
  }
  
  float getry()
  {
   return _ry; 
  }
}