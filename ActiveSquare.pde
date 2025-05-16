// probably could've just made all blocks have a color and have white be empty but whatever

public class ActiveBlock extends Block
{
  private int[] rgb;
  public ActiveBlock(int row, int col, int[] rgb)
  {
    super(row, col);
    this.rgb = rgb;
    super.isEmpty = false;
  }

// dont thinkn i need this
  public ActiveBlock(int row, int col, int[] rgb, boolean isEnd)
  {
    super(row, col);
    this.rgb = rgb;
    super.isEmpty = false;
    super.isEnd = isEnd;
  }
  
  public void show()
  {
    super.show();
    fill(rgb[0], rgb[1], rgb[2]);
  }
  public int[] getRGB()
  {
    return rgb;
  }
}
