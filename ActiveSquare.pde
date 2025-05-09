public class ActiveSquare extends Square
{
  private int[] rgb;
  public ActiveSquare(int row, int col, int[] rgb)
  {
    super(row, col);
    super.setEmpty(false);
    this.rgb = rgb;
  }
  public boolean isEqualTo(Square s)
  {
    if(s instanceof ActiveSquare)
    {
      for(int i = 0; i < 3; i++)
      {
        ActiveSquare a = (ActiveSquare) s;
        if(a.rgb[i] != rgb[i])
        {
          return false;
        }
      }
      return true;
    }
    return false;
  }
  public void setRGB(int[] rgb)
  {
    this.rgb = rgb;
  }
  public int[] getRGB()
  {
    return rgb;
  }
  public int getRed()
  {
    return rgb[0];
  }
  public int getGreen()
  {
    return rgb[1];
  }
  public int getBlue()
  {
    return rgb[2];
  }
  public void print()
  {
    System.out.println("Row: " + super.row + "\nCol: " + super.col + 
    "\nRGB: {" + rgb[0] + ", " + rgb[1] + ", " + rgb[2] + "}");
  }
}
