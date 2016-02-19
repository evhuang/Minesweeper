import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_BOMBS = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList < MSButton > bombs = new ArrayList < MSButton > (); //ArrayList of just the minesweeper buttons that are mined

void setup() {
    size(400, 400);
    textAlign(CENTER, CENTER);

    // make the manager
    Interactive.make(this);
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int j = 0; j < NUM_ROWS; j++) {
        for (int k = 0; k < NUM_COLS; k++) {
            buttons[j][k] = new MSButton(j, k);
        }
    }
    //declare and initialize buttons
    setBombs();
}
public void setBombs() {
    for (int i = 0; i < NUM_BOMBS; i++) {
        int aRow = (int)(Math.random() * 20);
        int aCol = (int)(Math.random() * 20);
        if (!bombs.contains(buttons[aRow][aCol])) {
            bombs.add(buttons[aRow][aCol]);
        }
    }
}

public void draw() {
    background(0);
    if (isWon())
        displayWinningMessage();
}
public boolean isWon() {
    //your code here
    return false;
}
public void displayLosingMessage() {
    //your code here
}
public void displayWinningMessage() {
    //your code here
}

public class MSButton {
    private int r, c;
    private float x, y, width, height;
    private boolean clicked, marked;
    private String label;

    public MSButton(int rr, int cc) {
        width = 400 / NUM_COLS;
        height = 400 / NUM_ROWS;
        r = rr;
        c = cc;
        x = c * width;
        y = r * height;
        label = "";
        marked = clicked = false;
        Interactive.add(this); // register it with the manager
    }
    public boolean isMarked() {
        return marked;
    }
    public boolean isClicked() {
            return clicked;
        }
        // called by manager

     public void mousePressed () 
    {
        if(mouseButton == LEFT)
        {
            if(clicked == false)
            {
                clicked = true;
                if(keyPressed == true)
                {
                    marked = !marked;
                }
                else if(bombs.contains(this))
                {
                    displayLosingMessage();
                }
                else if(countBombs(r,c)>0)
                {
                    label = label + countBombs(r,c);
//                    println("label");
                }
                else
                {
                    for(int i=-1;i<2;i++)
                    {
                        for(int j=-1;j<2;j++)
                        {
                            if(isValid(r+i,c+j)==true)
                            {
                                if(buttons[r+i][c+j].isClicked()==false)
                                {
                                    buttons[r+i][c+j].mousePressed();
                                }
                            }
                        }
                    }
                }
            }
        }
        if(mouseButton==RIGHT)
        {
            if(clicked == false)
            {
                marked=!marked;
            }
        }
    }


    public void draw() {
        if (marked)
            fill(0);
        else if (clicked && bombs.contains(this))
            fill(255, 0, 0);
        else if (clicked)
            fill(200);
        else
            fill(100);

        rect(x, y, width, height);
        fill(0);
        text(label, x + width / 2, y + height / 2);
    }
    public void setLabel(String newLabel) {
        label = newLabel;
    }
    public boolean isValid(int r, int c) {
        if ((r > -1 && r < 20) && (c > -1 && c < 20)) {
            return true;
        }
        return false;
    }
     public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int i=-1;i<2;i++)
        {
            for(int j=-1;j<2;j++)
            {
                if(isValid(row+i,col+j)==true)
                {
                    if(bombs.contains(buttons[row+i][col+j]))
                    {
                        numBombs++;
                    }
                }
            }
        }
        return numBombs;
    }
}