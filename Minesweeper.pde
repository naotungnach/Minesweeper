import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 15;
int NUM_COLS = 15;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
boolean lost = false;
boolean won = false;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    setMines();
}
public void setMines()
{
    for (int i = 0; i < 19; i++){
      int g = (int)(Math.random()*NUM_ROWS);
      int h = (int)(Math.random()*NUM_COLS);
      if ((mines.contains(buttons[g][h]))==false){
        mines.add(buttons[g][h]);
      }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
    //displayWinningMessage();
}
public boolean isWon()
{
    int sumwon = 0;
    for (int i = 0; i < mines.size(); i++){
      if (mines.get(i).flagged)
        sumwon++;
    }
    if (sumwon == 18)
      return true;
    return false;
}
public void displayLosingMessage()
{
    lost = true;
    //for (int j = 0; j < NUM_ROWS; j++){
    //  for (int k = 0; k < NUM_COLS; k++){
    //    if (mines.contains(buttons[j][k])){
    //      fill(255,0,0);
    //    }
    //  }
    //}
    for (int s = 0; s < mines.size(); s++){
      if (mines.get(s).clicked == false)
        mines.get(s).mousePressed();
    }
    buttons[5][0].setLabel("y");
    buttons[5][1].setLabel("o");
    buttons[5][2].setLabel("u");
    buttons[5][3].setLabel(" ");
    buttons[5][4].setLabel("l");
    buttons[5][5].setLabel("o");
    buttons[5][6].setLabel("s");
    buttons[5][7].setLabel("e");
    buttons[5][8].setLabel(" ");
    buttons[5][9].setLabel(":");
    buttons[5][10].setLabel("(");
    stop();
}
public void displayWinningMessage()
{
    won = true;
    buttons[5][0].setLabel("y");
    buttons[5][1].setLabel("o");
    buttons[5][2].setLabel("u");
    buttons[5][3].setLabel(" ");
    buttons[5][4].setLabel("w");
    buttons[5][5].setLabel("o");
    buttons[5][6].setLabel("n");
    buttons[5][7].setLabel("!");
    buttons[5][9].setLabel(":");
    buttons[5][10].setLabel(")");
    stop();
}
public boolean isValid(int r, int c)
{
    if ((r>=0)&&(r<NUM_ROWS)&&(c>=0)&&(c<NUM_COLS))
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if ((isValid(row-1,col-1))&&(mines.contains(buttons[row-1][col-1])))
      numMines++;
    if ((isValid(row-1,col))&&(mines.contains(buttons[row-1][col])))
      numMines++;
    if ((isValid(row-1,col+1))&&(mines.contains(buttons[row-1][col+1])))
      numMines++;
    if ((isValid(row,col-1))&&(mines.contains(buttons[row][col-1])))
      numMines++;
    if ((isValid(row,col+1))&&(mines.contains(buttons[row][col+1])))
      numMines++;
    if ((isValid(row+1,col-1))&&(mines.contains(buttons[row+1][col-1])))
      numMines++;
    if ((isValid(row+1,col))&&(mines.contains(buttons[row+1][col])))
      numMines++;
    if ((isValid(row+1,col+1))&&(mines.contains(buttons[row+1][col+1])))
      numMines++;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
       
        clicked = true;
        if (lost == false){
          if (mouseButton == RIGHT){
            if (flagged == true){flagged = false;}
            else
              flagged = true;
            }
          else if (mines.contains(this)){displayLosingMessage();}
          else if (countMines(myRow, myCol) > 0){setLabel(countMines(myRow, myCol));}
          else{
            if ((isValid(myRow-1,myCol-1))&&(!buttons[myRow-1][myCol-1].clicked)){
              buttons[myRow-1][myCol-1].mousePressed();}
            if ((isValid(myRow-1,myCol))&&(!buttons[myRow-1][myCol].clicked)){
              buttons[myRow-1][myCol].mousePressed();}
            if ((isValid(myRow-1,myCol+1))&&(!buttons[myRow-1][myCol+1].clicked)){
              buttons[myRow-1][myCol+1].mousePressed();}
            if ((isValid(myRow,myCol-1))&&(!buttons[myRow][myCol-1].clicked)){
              buttons[myRow][myCol-1].mousePressed();}
            if ((isValid(myRow,myCol+1))&&(!buttons[myRow][myCol+1].clicked)){
              buttons[myRow][myCol+1].mousePressed();}
            if ((isValid(myRow+1,myCol-1))&&(!buttons[myRow+1][myCol-1].clicked)){
              buttons[myRow+1][myCol-1].mousePressed();}
            if ((isValid(myRow+1,myCol))&&(!buttons[myRow+1][myCol].clicked)){
              buttons[myRow+1][myCol].mousePressed();}
            if ((isValid(myRow+1,myCol+1))&&(!buttons[myRow+1][myCol+1].clicked)){
              buttons[myRow+1][myCol+1].mousePressed();}
          }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
