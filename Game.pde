private int cols;
private int rows;
private int size = 50;
private Block[][] blocks;
// store for generator
private allPuzzles puzzles;

private Block[][] mySolution;
private int[] currColor = new int[]{255, 255, 255};
private Solver s;

public void setup() 
{
  puzzles = new allPuzzles();
  blocks = puzzles.puzzle(1);
  // *** MUST CHANGE SIZE MANUALLY ***
  // cant use variables for some reason not sure why
  size(350, 400);
  
  rows = floor((height - 50) / size);
  cols = floor(width / size);
  for (int r = 0; r < rows; r++) 
  {
    for (int c = 0; c < cols; c++) 
    {
      blocks[r][c].addNeighbors();
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
  fill(255, 255, 255);
  rect((width - 130) / 2, 10, 130, 30);
  fill(0, 0, 0);
  textSize(20);
  text("Show Answer", (width - 130) / 2 + 8, 30);
}

public void mouseClicked()
{
  for(int r = 0; r < rows; r++)
  {
    for(int c = 0; c < cols; c++)
    {
      Block b = blocks[r][c];
      if(mouseX >= b.getX() && mouseX < b.getX() + size && mouseY >= b.getY() && mouseY < b.getY() + size)
      {
        if(blocks[r][c].isEnd())
        {
          currColor = b.getRGB();
        }
        else
        {
          blocks[r][c] = new Block(r, c, currColor, false);
          fill(currColor[0], currColor[1], currColor[2]);
          b.show();
        }
      }
    }
  }
  
  {
    if(mouseX >= (width - 130) / 2 && mouseX < (width - 130) / 2 + 130 && mouseY >= 10 && mouseY < 40)
    {
      for(int r = 0; r < mySolution.length; r++)
      {
        for(int c = 0; c < mySolution[r].length; c++)
        {
          Block b = mySolution[r][c];
          fill(b.getRGB()[0], b.getRGB()[1], b.getRGB()[2]);
          b.show();
        }
      }
    }
  }
}
