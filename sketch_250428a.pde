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

/*

  int[][] onePath =   {
                      {0, 2}, 
                      {2, 3}
                      };
  int[][] twoPath =   {
                      {0, 3}, 
                      {1, 1}
                      };
  int[][] threePath = {
                      {0, 10}, 
                      {9, 4}
                      };
  int[][] fourPath =  {
                      {5, 7}, 
                      {6, 8}
                      };
  int[][] fivePath =  {
                      {8, 2}, 
                      {3, 3}
                      };
  int[][] sixPath =   {
                      {5, 8},
                      {10, 7}
                      };
  int[][] sevenPath = {
                      {3, 0}, 
                      {3, 9}
                      };
  int[][] eightPath = {
                      {3, 1}, 
                      {4, 3}
                      };
  int[][] ninePath =  {
                      {2, 5}, 
                      {8, 2}
                      };
  int[][] tenPath =   {
                      {8, 8}, 
                      {9, 9}
                      };
  int[][] elevenPath = {
                       {1, 5}, 
                       {1, 10}
                       };
  int[][] twelvePath = {
                       {5, 10}, 
                       {9, 7}
                       };
*/
