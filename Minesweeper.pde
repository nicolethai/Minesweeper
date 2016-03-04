

import de.bezier.guido.*;
public final int NUM_ROWS = 20, NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++) {
        for(int c = 0; c < NUM_COLS; c++) {
            buttons[r][c] = new MSButton(r, c);
        }
    }
    
    setBombs();
}
public void setBombs()
{
    int row = (int)(Math.random()*NUM_ROWS),
        col = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[row][col])) {
        bombs.add(buttons[row][col]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        
        int tf = (int)((Math.random()*2)-1);
        if(keyPressed) {
            if(tf == -1)
                marked = false;
            else             
                marked = true;
        }
        else if (bombs.contains(this)) {
            displayLosingMessage();
        }
        else if (countBombs(r, c) > 0) {
            setLabel(""+countBombs(r,c));
        }
        else {
            for(int rr = -1; rr <= 1; rr++) {
                for(int cc = -1; cc <= 1; cc++) {
                    if(r+rr!=r && c+cc!=c && buttons[r+rr][c+cc].isValid(r+rr, c+cc) && (buttons[r+rr][c+cc].isClicked()==false))
                        buttons[r+rr][c+cc].mousePressed();
                }
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if((r>=0 && r<=height) && (c>=0 && c<=width)) {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        // checks 8 neighbors around
/*        for(int r = -1; r <= 1; r++) {
            for(int c = -1; c <= 1; c++) {
                if(row+r!=row && col+c!=col && buttons[row+r][col+c].isValid(row+r, col+c) && bombs.contains(buttons[row+r][col+c]))
                    numBombs++;
            }
        }
*/
        // need check 8 neighbors around --> NEED CONDENSE
        if(buttons[row][col+1].isValid(row, col+1) && (bombs.contains(buttons[row][col+1]))) // checks right box
        {
            numBombs++;
        }
        if(buttons[row-1][col+1].isValid(row-1, col+1) && (bombs.contains(buttons[row-1][col+1]))) // checks right top box
        {
            numBombs++;
        }
        if(buttons[row+1][col+1].isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1])) // checks right bottom box
        {
            numBombs++;
        }
        if(buttons[row][col-1].isValid(row, col-1) && (bombs.contains(buttons[row][col-1]))) // checks left box
        {
            numBombs++;
        }
        if(buttons[row-1][col-1].isValid(row-1, col-1) && (bombs.contains(buttons[row-1][col-1]))) // checks left top box
        {
            numBombs++;
        }
        if(buttons[row+1][col-1].isValid(row+1, col-1) && (bombs.contains(buttons[row+1][col-1]))) // checks left bottom box
        {
            numBombs++;
        }
        if(buttons[row-1][col].isValid(row-1, col) && (bombs.contains(buttons[row-1][col]))) // checks top box
        {
            numBombs++;
        }
        if(buttons[row+1][col].isValid(row+1, col) && (bombs.contains(buttons[row+1][col]))) // checks bottom box
        {
            numBombs++;
        }


        return numBombs;
    }
}



