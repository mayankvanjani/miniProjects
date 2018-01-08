// MEMBERS: Mayank Vanjani, Andy Tu, David Veller
// Period 3, TOWERS OF HANOI FINAL PROJECT

import java.util.*;

// PEGS
Stack<Blocks> p1;
Stack<Blocks> p2;
Stack<Blocks> p3;

// All the blocks
ArrayList<Blocks> game;

//Num Disks
int disks = 7;

//Switch for auto solve
boolean button = false;
int x = 25;
int y = 25;
int w = 150;
int h = 75;


void setup() {
  size( 1080, 720 );
  game = new ArrayList<Blocks>();
  p1 = new Stack<Blocks>();
  p2 = new Stack<Blocks>();
  p3 = new Stack<Blocks>();
  
  
  //Add Blocks to Game and Stacks
  for( int i = 0; i < disks; i++ ) {
     Blocks temp = new Blocks( i, disks, height, width, 1);
     p1.push(temp);
     game.add(temp);
     temp.display();
  }
}

void draw() {
  background( 190 ); // Resets 
  fill( 255, 160, 122 ); // peg color
  //Draw Pegs
  rect( width/6, height/5, 10, (4*height/5)-1,5,5,0,0);
  rect( 3*width/6, height/5, 10, (4*height/5)-1,5,5,0,0);  
  rect( 5*width/6, height/5, 10, (4*height/5)-1,5,5,0,0);
  
  // For only the top of the stack to be moved
  if (!(p1.isEmpty())) {
    p1.peek().isOver(mouseX,mouseY);
    p1.peek().drag(mouseX,mouseY);
    p1.peek().display();
  }
  if (!(p2.isEmpty())) {
    p2.peek().isOver(mouseX,mouseY);
    p2.peek().drag(mouseX,mouseY);
    p2.peek().display();
  }
  if (!(p3.isEmpty())) {
    p3.peek().isOver(mouseX,mouseY);
    p3.peek().drag(mouseX,mouseY);
    p3.peek().display();
  }
  
  // Entire Stack
  for (int i = 0; i < game.size(); i++) {
    fill( i*(255/disks),255,255);
    game.get(i).display();
  }
  
  //Button
  fill( 255,255,255 );
  rect ( x,y,w,h );
  fill( 0,0,0 );
  textSize(20);
  text("AUTO-SOLVE", 36,70);
  if (button) {
    autoSolve();
  }
}

void mousePressed() {
  if (!button) {
    if (!(p1.isEmpty())) {
      p1.peek().isClicked(mouseX,mouseY);
    }
    if (!(p2.isEmpty())) {
      p2.peek().isClicked(mouseX,mouseY);
    }
    if (!(p3.isEmpty())) {
      p3.peek().isClicked(mouseX,mouseY);
    }
  }
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    button = !button;
  }
}

void mouseReleased() {
  if (!(p1.isEmpty())) {
    p1.peek().stopDragging();
      snap1(p1.peek());
    if (!(p1.isEmpty()))
      snap2(p1.peek());
    if (!(p1.isEmpty()))
      snap3(p1.peek());
  }
  if (!(p2.isEmpty())) {
    p2.peek().stopDragging(); 
    snap2(p2.peek());
    if (!(p2.isEmpty()))
      snap1(p2.peek());
    if (!(p2.isEmpty()))
      snap3(p2.peek());
  }
  if (!(p3.isEmpty())) {
    p3.peek().stopDragging();
    snap3(p3.peek());
    if (!(p3.isEmpty()))
      snap1(p3.peek());
    if (!(p3.isEmpty()))
      snap2(p3.peek());
  }
}


Stack<Blocks> findPeg (Blocks b) {
  if ( (!(p1.isEmpty())) && b == p1.peek())
    return p1;
  else if ( (!(p2.isEmpty())) && b == p2.peek())
    return p2;
  else if ( (!(p3.isEmpty())) && b == p3.peek())
    return p3;
  return null;
}

int numBlocks (Stack<Blocks> p) {
  int counter = 0;
  Stack<Blocks> temp = p;
  while (!(temp.isEmpty())) {
   temp.pop();
   counter++;
  } 
   return counter; 
}

 void snapback( Blocks b ) {
   if ( findPeg(b) == p1 ) {
     basicSnap1(b);
   }
   if ( findPeg(b) == p2 ) {
     basicSnap2(b);
   }
   if ( findPeg(b) == p3 ) {
     basicSnap3(b);
   }
 }
 boolean basicSnap1(Blocks b) {
        if ( !p1.isEmpty() && b.size > p1.peek().size) {
        snapback(b);
        return false;
        }
        int i = 10-p1.size();
//        if ( i == p1.size() ) {
//          i--;
//        }
        b.setX((width/6) - b.w/2 + 5);
        b.setY(i*height/10-1); 
        p1.push(findPeg(b).pop());
        return true;
 }
 void snap1(Blocks b) {
    if ( 0 <= b.x_cor && b.x_cor <= (1080/3) ) {
      basicSnap1(b);
    }
   }
 boolean basicSnap2(Blocks b) {
       if ( !p2.isEmpty() && b.size > p2.peek().size) {
          snapback(b);
          return false;
       }
        int i = 10-p2.size();
//        if ( i == p2.size() ) {
//          i--;
//        }
        b.setX((3*width/6) - b.w/2 + 5);
        b.setY(i*height/10-1); 
        p2.push(findPeg(b).pop()); 
        return true;

  }
 
 void snap2(Blocks b) {
    if ( b.x_cor > (1080/3) && b.x_cor <= (1080/3) * 2) {
      basicSnap2(b);
    }
 }
 boolean basicSnap3(Blocks b) {
        if ( !p3.isEmpty() && b.size > p3.peek().size ) {
          snapback(b);
          return false;
        }  
        int i = 10-p3.size();
//        if ( i == p3.size() ) {
//          i--;
//        }
        b.setX((5*width/6) - b.w/2 + 5);
        b.setY(i*height/10-1); 
        p3.push(findPeg(b).pop());
        return true;
 
 }  
 void snap3(Blocks b) {
    if ( b.x_cor > (1080/3) * 2 && b.x_cor <= 1080 ) {
      basicSnap3(b);
    }
 }

void autoSolve(){
    if( !p1.isEmpty() ) {
      if (!basicSnap2(p1.peek())) {
        basicSnap1(p2.peek());
      }
    }
    delay(200);
    if( !p1.isEmpty() ) {
      if (!basicSnap3(p1.peek())) {
        basicSnap1(p3.peek());
    }
    }
    delay(200);
    if( !p2.isEmpty() ) {
      if (!basicSnap3(p2.peek())) {
       basicSnap2(p3.peek()); 
      }
    }
    delay(200);
}
