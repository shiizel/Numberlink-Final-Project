private static final int LENGTH = 50;

public class Square
{
  private int x;
  private int y;
  private int row;
  private int col;

    public Square(int row, int col)
    {
      x = row * LENGTH;
      y = col * LENGTH;
      this.row = row;
      this.col = col;
    }
    public void show()
    {
      square(x, y, LENGTH);
    }
}
public static int getLength()
{
  return LENGTH;
}
    
