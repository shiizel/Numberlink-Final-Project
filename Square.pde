private static final int LENGTH = 50;

public class Square
{
  private int x;
  private int y;
  private int row;
  private int col;
  private boolean isEmpty = true;

    public Square(int row, int col)
    {
      x = row * LENGTH;
      y = col * LENGTH;
      this.row = row;
      this.col = col;
    }
    public void show()
    {
      line(x, y, x + getLength(), y);
      line(x + getLength(), y, x + getLength(), y + getLength());
      line(x + getLength(), y + getLength(), x, y + getLength());
      line(x, y + getLength(), x, y);
    }

    public int getRow()
    {
      return row;
    }
    public int getCol()
    {
      return col;
    }
    public void setEmpty(boolean e)
    {
      isEmpty = e;
    }
    public int getX()
    {
      return x;
    }
    public int getY()
    {
      return y;
    }
}
public static int getLength()
{
  return LENGTH;
}
    
