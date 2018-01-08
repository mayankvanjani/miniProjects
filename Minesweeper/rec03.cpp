/*
  Minesweeper Lab
  Mayank Vanjani
  CS2114
  NYU Tandon School of Engineering
  9/22/17
*/

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>
using namespace std;

struct tile {
  bool isBomb;
  char show; // ' ', '?'
  int neighbors;
};

class Minesweeper {
  
public:

  Minesweeper () {
    int rows = 9;
    int cols = 9;
    srand(time(NULL));
    for (int r = 0; r < rows; ++r) {
      vector<tile> aRow;
      for (int c = 0; c < cols; ++c) {
	tile newTile;
	newTile.show = '?';
	if (rand() % 100 < 10) {
	  newTile.isBomb = true;
	}
	else {
	  newTile.isBomb = false;
	}	
	aRow.push_back(newTile);
      }
      board.push_back(aRow);
    }


    for (size_t r = 0; r < board.size(); ++r) {
      for (size_t c = 0; c < board[r].size(); ++c) {

	if ( validRow(r-1) && validCol(c-1) ) {
	  if ( board[r-1][c-1].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}	    
	    
	if ( validRow(r-1) && validCol(c) ) {
	  if ( board[r-1][c].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}

	if ( validRow(r-1) && validCol(c+1) ) {
	  if ( board[r-1][c+1].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}

	if ( validRow(r) && validCol(c-1) ) {
	  if ( board[r][c-1].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}

	if ( validRow(r) && validCol(c+1) ) {
	  if ( board[r][c+1].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}

	if ( validRow(r+1) && validCol(c-1) ) {
	  if ( board[r+1][c-1].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}

	if ( validRow(r+1) && validCol(c) ) {
	  if ( board[r+1][c].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}

	if ( validRow(r+1) && validCol(c+1) ) {
	  if ( board[r+1][c+1].isBomb ) {
	    board[r][c].neighbors += 1;
	  }
	}
		
      }
    }

    /*
    for (size_t r = 0; r < board.size(); ++r) {
      for (size_t c = 0; c < board[r].size(); ++c) {
	if (board[r][c].isBomb) {
	  cout << 'X';
	}
	else {
	  cout << board[r][c].neighbors;
	}
      }
      cout << endl;
    }
    cout << endl;
    */

  }



  
  void display(bool disp) const {
    if (disp) {
      for (size_t r = 0; r < board.size(); ++r) {
	for (size_t c = 0; c < board[r].size(); ++c) {
	  if (board[r][c].isBomb) {
	    cout << 'X';
	  }
	  else if (board[r][c].neighbors > 0) {
	    cout << board[r][c].neighbors;
	  }
	  else {
	    cout << ' ';
	  }
	}
	cout << endl;
      }
    }
    else {
      for (size_t r = 0; r < board.size(); ++r) {
	for (size_t c = 0; c < board[r].size(); ++c) {
	  if (board[r][c].show == ' ' && board[r][c].neighbors > 0) {
	    cout << board[r][c].neighbors;
	  }
	  else {
	    cout << board[r][c].show;
	  }
	}
	cout << endl;
      }
      
    }
  }
  
  bool done() const {
    for (size_t r = 0; r < board.size(); ++r) {
      for (size_t c = 0; c < board[r].size(); ++c) {
	if (board[r][c].show == '?') {
	  return false;
	}
      }
    }
    return true;
  }

  bool validRow( int row ) const {
    int temp = 0;
    if (row > -1) {
      for (size_t r = 0; r < board.size(); ++r) {
	temp++;
      }
      if (row < temp) {
	return true;
      }
    }
    return false;
  }

  bool validCol( int col ) const {
    int temp = 0;
    if (col < 0) {
      return false;
    }
    
    else {
      for (size_t r = 0; r < board.size(); ++r) {
	for (size_t c = 0; c < board[r].size(); ++c) {
	  temp++;
	}
	if (col >= temp) {
	  return false;
	}
	temp = 0;
      }
    }
    return true;
  }

  bool isVisible( int row, int col ) const {
    if (board[row][col].show == ' ') {
      return true;
    }
    return false;
  }

  bool isVisible( tile t ) const {
    if (t.show == ' ') {
      return true;
    }
    return false;
  }

  bool play( int row, int col ) {
    if (board[row][col].isBomb) {
      return false;      
    }
    else {
      if (!isVisible(row,col)) {
	board[row][col].show = ' ';
      }
      if (board[row][col].neighbors == 0) {
	
	if ( validRow(row-1) && validCol(col-1) && board[row-1][col-1].show != ' ') {
	  play(row-1,col-1);
	}
	
	if ( validRow(row-1) && validCol(col) && board[row-1][col].show != ' ') {
	  play(row-1,col);
	}
	
	if ( validRow(row-1) && validCol(col+1) && board[row-1][col+1].show != ' ') {
	  play(row-1,col+1);
	}
	if ( validRow(row) && validCol(col-1) && board[row][col-1].show != ' ') {
	  play(row,col-1);
	}
	
	if ( validRow(row) && validCol(col+1) && board[row][col+1].show != ' ') {
	  play(row,col+1);
	}
	if ( validRow(row+1) && validCol(col-1) && board[row+1][col-1].show != ' ') {
	  play(row+1,col-1);
	}
	if ( validRow(row+1) && validCol(col) && board[row+1][col].show != ' ') {
	  play(row+1,col);
	}
	if ( validRow(row+1) && validCol(col+1) && board[row+1][col+1].show != ' ') {
	  play(row+1,col+1);
	}
      }
    
    }

    return true;
  }

private:
  vector<vector<tile>> board;      

};



int main() {
  Minesweeper sweeper;
  // Continue until the only invisible cells are bombs
  //sweeper.display(false);
  //cout << endl;
  //sweeper.display(true);


  /*
  for (int i = -2; i < 15; ++i) {
    bool check = sweeper.validRow(i);
    bool check2 = sweeper.validCol(i);
    cout << i << ": " << check << " " << check2 << endl;
  }
  */
  
  while (!sweeper.done()) {
    sweeper.display(false); // display the board without bombs
    cout << endl;
    //    sweeper.display(true);
    //cout << endl;
    
    int row_sel = -1, col_sel = -1;
    while (row_sel == -1) {
      // Get a valid move
      int r, c;
      cout << "row? ";
      cin >> r;
      if (!sweeper.validRow(r)) {
	cout << "Row out of bounds\n";
	continue;
      }
      cout << "col? ";
      cin >> c;
      if (!sweeper.validCol(c)) {
	cout << "Column out of bounds\n";
	continue;
      }
      if (sweeper.isVisible(r,c)) {
	cout << "Square already visible\n";
	continue;
      }
      row_sel = r;
      col_sel = c;
    }
    // Set selected square to be visible. May effect other cells.
    if (!sweeper.play(row_sel,col_sel)) {
      cout << "BOOM!!!\n";
      sweeper.display(true);
      // We're done! Should consider ending more "cleanly",
      // eg. Ask user to play another game.
      exit(0);
    }
  }
  // Ah! All invisible cells are bombs, so you won!
  cout << "You won!!!!\n";
  sweeper.display(true); // Final board with bombs shown

}

