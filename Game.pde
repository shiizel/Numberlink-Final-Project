// https://www.youtube.com/watch?v=zsG2ceOlY6I

private int cols;
private int rows;
private int size = 50;
public Block[][] blocks;
// store for generator
private ActiveBlock[][] solution;

private Solver s;

Block currentBlock;
boolean isGridFinished = false;

public void setup() {
  size(200, 200);
  rows = floor(height / size);
  cols = floor(width / size);
  blocks = new Block[rows][cols];

  for (int i = 0; i < rows; i++) 
  {
    for (int j = 0; j < cols; j++) 
    {
      
      if(i == 0 && j == 0)
      {
          // red
          blocks[i][j] = new ActiveBlock(i, j, new int[]{255, 0, 0}, true);
      }
      else if(i == 0 && j == 1)
      {
          // blue
          blocks[i][j] = new ActiveBlock(i, j, new int[]{0, 0, 255}, true);
      }
      else if(i == 1 && j == 2)
      {
          // green
          blocks[i][j] = new ActiveBlock(i, j, new int[]{0, 255, 0}, true);
      }
      else if(i == 2 && j == 1)
      {
          // green
          blocks[i][j] = new ActiveBlock(i, j, new int[]{0, 255, 0}, true);
      }
      else if(i == 2 && j == 2)
      {
          // blue
          blocks[i][j] = new ActiveBlock(i, j, new int[]{0, 0, 255}, true);
      }
      else if(i == 3 && j == 3)
      {
        // red
          blocks[i][j] = new ActiveBlock(i, j, new int[]{255, 0, 0}, true);
      }
      else
      {
        blocks[i][j] = new Block(i, j);
      }
    }
  }
  for (int i = 0; i < rows; i++) 
  {
    for (int j = 0; j < cols; j++) 
    {
      blocks[i][j].addNeighbors();
    }
  }
  
  currentBlock = blocks[0][0];
  currentBlock.visitedByAlgo = true;

  frameRate(10);
  
    strokeWeight(4);
    stroke(255, 255, 0);
    
    for (int i = 0; i < rows; i++) 
    {
      for (int j = 0; j < cols; j++) 
      {
        blocks[i][j].show();
        // added this
        
        if(blocks[i][j] instanceof ActiveBlock)
        {
          ActiveBlock a = (ActiveBlock) blocks[i][j];
          fill(a.rgb[0], a.rgb[1], a.rgb[2]);
          square(a.getX(), a.getY(), size);
        }
      }
    }
  
  
  s = new Solver(blocks, rows, cols);
  solution = s.initSolver();
}


public void draw() 
{
  
  // something is very wrong with solver i think its the reversing
  /*
  for(int r = 0; r < solution.length; r++)
  {
    for(int c = 0; c < solution[r].length; c++)
    {
      if(solution[r][c] instanceof ActiveBlock)
        {
          ActiveBlock a = (ActiveBlock) solution[r][c];
          fill(a.rgb[0], a.rgb[1], a.rgb[2]);
          square(a.x, a.y, size);
        }
    }
  }
  */

void mouseClicked()
{
  int[] currcolor = new int[3];
    for(int r =0; r<4;r++)
    {
        for(int c=0; c<4; c++)
        {
          if(blocks[r][c] instanceof ActiveBlock)
          {
            ActiveBlock a = (ActiveBlock)blocks[r][c];
            if(mouseX >= a.getX() && mouseX<=a.getX()+size && mouseY>=a.getY() && mouseY<=a.getY()+size)
            {
               currcolor = a.getRGB();
             
            }
            
          }
           if(!blocks[r][c].isEnd)
        {
          Block b = blocks[r][c];
          if(mouseX >= b.getX() && mouseX<=b.getX()+size && mouseY>=b.getY() && mouseY<=b.getY()+size)
          {
            blocks[r][c] = new ActiveBlock(r, c, currcolor);
            fill(currcolor[0], currcolor[1], currcolor[2]);
            square(b.getX(), b.getY(), size);
          }
        }
         
        }
        
        
        
        
    }

}

