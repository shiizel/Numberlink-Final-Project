import java.util.ArrayList;

private Square[][] mySquares; 
private int width = 350;
private int height = 350;
private Square currentSquare;
private boolean isFinished = false;

//eventually make this a getter instead
public int rows;
public int cols;

public void settings()
{
  size(width, height);
}
public void setup()
{
  rows = height / getLength();
  cols = width / getLength();
  
  mySquares = new Square[rows][cols];
  for(int x = 0; x < rows; x++)
  {
    for(int y = 0; y < cols; y++)
    {
      mySquares[x][y] = new Square(x, y);
    }
  }
  
  
  // this would be the first node pair?
  currentSquare = mySquares[5][0];
  currentSquare.setEmpty(false);
  
  frameRate(10);
 
}
public void draw()
{
  if(!isFinished)
  {
    
    background(0, 255, 255);
    strokeWeight(4);
    for(int x = 0; x < rows; x++)
    {
      for(int y = 0; y < cols; y++)
      {
        mySquares[x][y].show();
      }
    }
    // this is how to marks the occupying color
    fill(193, 50, 193);
    // draws a new currentSquare over the grid
    square(currentSquare.getX(), currentSquare.getY(), getLength());
  }
}
