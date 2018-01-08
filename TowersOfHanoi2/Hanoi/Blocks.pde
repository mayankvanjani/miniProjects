import java.util.*;

class Blocks {
  int x_cor;
  int x;
  int y_cor;
  int y;
  int h; // height
  int w; // width
  int radii; // radius of block curves
  int size;
  int mouseCoorX, mouseCoorY; //mouse coordinates
  
  
  boolean dragging = false; // is object dragged rn
  boolean over = false; // is mouse over block
  boolean check = false;
  
  Blocks( int i, int disks, int rectHeight, int rectWidth, int peg) {
     w = 200-10*(i);
     h = rectHeight/10;
     x_cor = x = (rectWidth/6-5*(disks-i))-(60+5*(7-disks)) + (peg*2-2) * 720/4;
     y_cor = y = (9-i)*rectHeight/10-1;
     fill( i*(255/disks),255,255);
     size = 7-i;
     mouseCoorX = 0;
     mouseCoorY = 0;
     //rect( x_cor, y_cor, w, h, 30);
  }
  
  void setX( int xval ) {
    x_cor = xval;
  }
  void setY( int yval ) {
    y_cor = yval;
  }
  
  void display() { 
    rect( x_cor, y_cor, w, h, 30);
  }
  
  void isClicked(int mx, int my) {
      if ( mx > x_cor && mx < (x_cor + w) && my > y_cor && my < (y_cor + h) ) {
        dragging = true;
        mouseCoorX = x_cor - mx;
        mouseCoorY = y_cor - my;
      }
  }
  
  void isOver(int mx, int my) {
   if ( mx > x_cor && mx < (x_cor + w) && my > y_cor && my < (y_cor + h) ) {
     over = true;
    } 
   else {
     over = false;
    }
  }
  
  void stopDragging() {
    dragging = false;
    //snap();
  }
  
  void drag(int mx, int my) {
    if (dragging) {
      x_cor = mx + mouseCoorX;
      y_cor = my + mouseCoorY;
    }
  }


  
/*
  if inDisk {
   if mouseclicked {
      if dragged {
        pop stack
        draw background
        new rect
      }
      if mouseLetGo{
        snap();
      }
 }
}
 */          
}

