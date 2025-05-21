// https://www.youtube.com/watch?v=zsG2ceOlY6I

private int cols;
private int rows;
private int size = 50;
public Block[][] blocks;
// store for generator

private Block[][] mySolution;
private int[] currColor = new int[3];

private Solver s;

Block currentBlock;
boolean isGridFinished = false;

public void setup() {
  size(350, 350);
  rows = floor(height / size);
  cols = floor(width / size);
  blocks = new Block[rows][cols];

  for (int i = 0; i < rows; i++) 
  {
    for (int j = 0; j < cols; j++) 
    {
      // 350, 350
      blocks[i][j] = new Block(i, j, new int[]{255, 255, 255});
      
      blocks[4][2] = new Block(4, 2, new int[]{255, 0, 0}, true);
      blocks[2][5] = new Block(2, 5, new int[]{255, 0, 0}, true);
      
      blocks[0][6] = new Block(0, 6, new int[]{0, 255, 0}, true);
      blocks[4][1] = new Block(4, 1, new int[]{0, 255, 0}, true);
     
      blocks[3][2] = new Block(3, 2, new int[]{0, 0, 255}, true);
      blocks[1][1] = new Block(1, 1, new int[]{0, 0, 255}, true);
      
      blocks[3][0] = new Block(3, 0, new int[]{255, 255, 0}, true);
      blocks[4][6] = new Block(4, 6, new int[]{255, 255, 0}, true);
      
      blocks[5][1] = new Block(5, 1, new int[]{0, 255, 255}, true);
      blocks[3][3] = new Block(3, 3, new int[]{0, 255, 255}, true);
      
      /*
      // 550, 550
      // takes unreasonably long
      blocks[i][j] = new Block(i, j, new int[]{255, 255, 255});
      
      blocks[0][2] = new Block(0, 2, new int[]{50, 0, 0}, true);
      blocks[2][3] = new Block(2, 3, new int[]{50, 0, 0}, true);
      
      blocks[1][1] = new Block(1, 1, new int[]{100, 0, 0}, true);
      blocks[0][3] = new Block(0, 3, new int[]{100, 0, 0}, true);
     
      blocks[9][4] = new Block(9, 4, new int[]{150, 0, 0}, true);
      blocks[0][10] = new Block(0, 10, new int[]{150, 0, 0}, true);
      
      blocks[5][7] = new Block(5, 7, new int[]{200, 0, 0}, true);
      blocks[6][8] = new Block(6, 8, new int[]{200, 0, 0}, true);
      
      blocks[8][2] = new Block(8, 2, new int[]{0, 50, 0}, true);
      blocks[3][3] = new Block(3, 3, new int[]{0, 50, 0}, true);
      
      blocks[10][7] = new Block(10, 7, new int[]{0, 100, 0}, true);
      blocks[5][8] = new Block(5, 8, new int[]{0, 100, 0}, true);
      
      blocks[3][0] = new Block(3, 0, new int[]{0, 150, 0}, true);
      blocks[3][9] = new Block(3, 9, new int[]{0, 150, 0}, true);
    
      blocks[3][1] = new Block(3, 1, new int[]{0, 200, 0}, true);
      blocks[4][3] = new Block(4, 3, new int[]{0, 200, 0}, true);
      
      blocks[8][7] = new Block(8, 7, new int[]{0, 0, 50}, true);
      blocks[2][5] = new Block(2, 5, new int[]{0, 0, 50}, true);
      
      blocks[9][9] = new Block(9, 9, new int[]{0, 0, 100}, true);
      blocks[8][8] = new Block(8, 8, new int[]{0, 0, 100}, true);
      
      blocks[1][5] = new Block(1, 5, new int[]{0, 0, 150}, true);
      blocks[1][10] = new Block(1, 10, new int[]{0, 0, 150}, true);
    
      blocks[9][7] = new Block(9, 7, new int[]{0, 0, 200}, true);
      blocks[5][10] = new Block(5, 10, new int[]{0, 0, 200}, true);
      */
      
      /*
      // 250, 250
      blocks[i][j] = new Block(i, j, new int[]{255, 255, 255});
      
      blocks[3][0] = new Block(3, 0, new int[]{255, 0, 0}, true);
      blocks[2][4] = new Block(2, 4, new int[]{255, 0, 0}, true);
      
      blocks[1][1] = new Block(1, 1, new int[]{0, 255, 0}, true);
      blocks[4][4] = new Block(4, 4, new int[]{0, 255, 0}, true);
      
      blocks[2][1] = new Block(2, 1, new int[]{0, 0, 255}, true);
      blocks[4][3] = new Block(4, 3, new int[]{0, 0, 255}, true);
      
      blocks[4][0] = new Block(4, 0, new int[]{255, 255, 0}, true);
      blocks[3][1] = new Block(3, 1, new int[]{255, 255, 0}, true);
      */
      /*
      blocks[i][j] = new Block(i, j, new int[]{255, 255, 255}, false);
      // red
      blocks[0][0] = new Block(0, 0, new int[]{255, 0, 0}, true);
      blocks[3][3] = new Block(3, 3, new int[]{255, 0, 0}, true);
      
      // blue
      blocks[0][1] = new Block(0, 1, new int[]{0, 0, 255}, true);
      blocks[2][2] = new Block(2, 2, new int[]{0, 0, 255}, true);
      
      // green
      blocks[1][2] = new Block(1, 2, new int[]{0, 255, 0}, true);
      blocks[2][1] = new Block(2, 1, new int[]{0, 255, 0}, true);
      */
    }
  }
  
  for (int i = 0; i < rows; i++) 
  {
    for (int j = 0; j < cols; j++) 
    {
      blocks[i][j].addNeighbors();
    }
  }
  
    strokeWeight(4);
    for (int i = 0; i < rows; i++) 
    {
      for (int j = 0; j < cols; j++) 
      {
        Block b = blocks[i][j];
        fill(b.rgb[0], b.rgb[1], b.rgb[2]);
        b.show();
      }
    }
  
  s = new Solver(blocks, rows, cols);
  mySolution = s.completeFlow();
}

public void draw() 
{
  for(int r = 0; r < mySolution.length; r++)
  {
    for(int c = 0; c < mySolution[r].length; c++)
    {
      Block b = mySolution[r][c];
      fill(b.getRGB()[0], b.getRGB()[1], b.getRGB()[2]);
      square(b.getX(), b.getY(), size);
    }
  }
}



void mouseClicked()
{
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      if(blocks[r][c].isEnd())
      {
        Block a = blocks[r][c];
        if(mouseX >= a.getX() && mouseX <= a.getX() + size && mouseY >= a.getY() && mouseY <= a.getY() + size)
        {
          currColor = a.getRGB();
        }   
      }
      if(!blocks[r][c].isEnd)
      {
        Block b = blocks[r][c];
        if(mouseX >= b.getX() && mouseX <= b.getX() + size && mouseY >= b.getY() && mouseY <= b.getY() + size)
        {
          blocks[r][c] = new Block(r, c, currColor, false);
          fill(currColor[0], currColor[1], currColor[2]);
          square(b.getX(), b.getY(), size);
        }
      }
    }
  }
}
