// initial values for branch width and length
float firstLength = 200;
float firstWidth = 18;

// upper and lower bounds for the random percentage by which branches will be shrunk each iteration
float minScale = .4;
float maxScale = .8;

// lower threshold for branch width and length. recursion will stop when either is reached
float minWidth = 1;
float minLength = 1;

// custom color for branch color
color trunk = color(92,64,51);

// shape object to be loaded with graphic for leaf
PShape leaf;

// minimum and maximum number of branches per split
int minBranches = 2;
int maxBranches = 5;

// minimum and maximum angle
float minAngle = -50;
float maxAngle = 50;

void setup() {
  // setup the window (size and color)
  fullScreen();
  stroke(trunk);

  // set up the leaf shape
  leaf = loadShape("leaf.svg");

  // make it so lower left is 0,0 now.
  translate(0,height);
  // make it so coords go up for y
  scale(1,-1);
}

void draw() {
}

void mousePressed() {
  // move to mouse position
  translate(mouseX,mouseY);
  // rotate so that measurements are more intuitive
  rotate(radians(180));
  tree(firstWidth * random(minScale,maxScale),firstLength * random(minScale,maxScale));
}

void tree(float w, float l) {
  // if this line is too thin or too short, draw "leaf" and stop
  if (w < minWidth || l < minLength) {
    pushMatrix();
    shape(leaf,0,0,constrain(w*15,3,10),constrain(w*15,3,10));
    popMatrix();
    return;
  }
  // draw current "branch"
  strokeWeight(w);
  line(0,0,0,l);
  
  // go to end of this line
  translate(0,l);
  
  // how many branches we gonna make?
  int numBranches = (int) random(minBranches,maxBranches + 1);
  
  // iterate through and draw at the angle
  float low = minAngle;
  float incr = (maxAngle - minAngle) / numBranches;
  float thisAngle;
  float shrinkWidth, shrinkLength;
    
  for (int i = 0; i < numBranches; i++) {
    // assign an angle between the low point and up to the next increment
    thisAngle = random(low, low + incr);
    // raise low by the increment
    low += incr;
     pushMatrix();
    //rotate by that angle
    rotate(radians(thisAngle));
    //come up with shrinkfactors
    shrinkWidth = random(minScale,maxScale);
    shrinkLength = random(minScale,maxScale);
    // draw the branch
    tree(w * shrinkWidth, l * shrinkLength);
    popMatrix();
  }
}