f = lambda x, a, b, c: ((x-a)**2 + b**2 - c**2) / (2*(b - c)) if b-c != 0 else 0

class cir:
    def __init__(self, x=None, y=None, rad=None):
        if rad==None:
            r = random(100, 300) if random(1) < 0.7 else random(200, 700)
        else:
            r = random(100, 300) if rad else random(300, 700)
        self.loc = PVector(random(10+r/2, width-10-r/2) if x==None else x, random(10+r/2,height-10-r/2) if y==None else y)
        self.r = r
    
    def show(self):
        ellipse(self.loc.x, self.loc.y, self.r, self.r)
        
    def parabshow(self, num=1000):
        stroke(95, 210, 250, 10) 
        for i in range(num):
            compute(self.loc.x, self.loc.y, self.r, random(0, TWO_PI))

def compute(x, y, r, a):
  n = 40    
  pushMatrix()
  translate(x, y)
  rotate(a)
  leng = (width**2+height**2)**0.5 + r*2
  inc = leng / n
  s = -leng / 2
  beginShape()
  for i in range(n+1):
      vertex(s, f(s, 0, 0, r))
      s += inc
  endShape()
  popMatrix()


circles = []
number = 5

def setup() :
  global circles
  fullScreen()
  background(0)
  smooth(1)
  noFill()
  blendMode(ADD)
  circles = [cir(random(width), random(height)) for _ in range(number)]
  
  
def build():
    background(0)
    for c in circles:
        c.parabshow()
  
def draw():
  build()
  noLoop()
  
def mousePressed():
    global circles
    if mouseButton == LEFT:
        print('saved')
        saveFrame()
    elif mouseButton == RIGHT:
        circles = [cir() for _ in range(number)]
        redraw()

def keyPressed():
    global circles
    if key == 's':
        circles.append(cir(mouseX, mouseY, True))
    if key == 'l':
        circles.append(cir(mouseX, mouseY, False))
    if key == 'd':
        circles = []
    redraw()
        
