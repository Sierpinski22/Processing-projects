class cir:
    def __init__(self, x=None, y=None, rad=None):
        if rad==None:
            r = random(100, 200) if random(1) < 0.7 else random(200, 700)
        else:
            r = random(100, 200) if rad else random(200, 700)
        self.loc = PVector(random(10+r/2, width-10-r/2) if x==None else x, random(10+r/2,height-10-r/2) if y==None else y)
        self.r = r
    
    def show(self):
        ellipse(self.loc.x, self.loc.y, self.r, self.r)
        
    def linshow(self, num):
        angle = 0
        for i in range(num):
            angle = random(0, TWO_PI)
            leng = (width**2+height**2)**0.5
            stroke(95, 210, 250, 10)
            strokeWeight(2)
            line(self.loc.x+self.r/2*cos(angle), self.loc.y+self.r/2*sin(angle),
                 self.loc.x+self.r/2*cos(angle) + leng*cos(angle+PI/2), 
                 self.loc.y+self.r/2*sin(angle) + leng*sin(angle+PI/2))        
            line(self.loc.x+self.r/2*cos(angle), self.loc.y+self.r/2*sin(angle),
                 self.loc.x+self.r/2*cos(angle) + leng*cos(angle-PI/2), 
                 self.loc.y+self.r/2*sin(angle) + leng*sin(angle-PI/2))        
        
        

crs = None
n = 4


def build():
    background(0)
    for c in crs:
        c.linshow(500)


def setup():
    global crs
    background(0)
    #size(1200, 600)
    fullScreen()
    blendMode(ADD)
    crs = [cir() for _ in range(n)]
    
    
def draw():      
    build()  
    noLoop()
    
        
def mousePressed():
    global crs
    if mouseButton == LEFT:
        print('saved')
        saveFrame()
    elif mouseButton == RIGHT:
        crs = [cir() for _ in range(n)]
        redraw()

def keyPressed():
    global crs
    if key == 's':
        crs.append(cir(mouseX, mouseY, True))
    if key == 'l':
        crs.append(cir(mouseX, mouseY, False))
    if key == 'd':
        crs = []
    redraw()
        

    
    
