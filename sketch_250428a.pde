import java.util.ArrayList;

private Square[][] mySquares; 
private int width = 550;
private int height = 550;
private int rows;
private int cols;

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
 
}
public void draw()
{
  for(int x = 0; x < rows; x++)
  {
    for(int y = 0; y < cols; y++)
    {
      mySquares[x][y].show();
    }
  }
}
