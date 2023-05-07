# particle flow

side = 10

dt = 0.5
field = None
w, h = 0, 0
inc = 0.1
vmax = 2
p = None
n = 2500

f = None

class particle:
    def __init__(self, x=None, y=None, c=None):
        x = x if not x is None else random(w)
        y = y if not y is None else random(h)
        
        self.loc = PVector(x, y)
        self.prev = self.loc.copy()
        self.vel = PVector(0, 0)
        self.acc = PVector(0, 0)
        self.life, self.maxl = 70, 70
        self.radm = 50
        self.mass = 1
        self.jump = False
        self.c = c
        
    def apply_force(self, force):
        self.acc.add(force / self.mass)
        
    def move(self):
        if self.life > 0:
            self.prev = self.loc.copy()
            self.vel += self.acc
            self.acc.mult(0)
            
            self.loc += dt * self.vel.limit(vmax)
            
            if not 0 < self.loc.x < w: 
                self.loc.x = self.loc.x % w
                self.jump = True
                
            if not 0 <self.loc.y < h:
                self.loc.y = self.loc.y % h
                self.jump = True
            
            self.life -= 1
            self.show()
            self.jump = False
    
    def show(self):
        #fill(200-200* self.life / self.maxl, 300, 300)
        stroke(frameCount * 4 % 300, 300, 300, 7)
        if not self.c is None:
            stroke(self.c, 300, 300, 3)
        else:
            stroke(frameCount * 4 % 300, 300, 300, 20)
            
        #fill(255*self.life / self.maxl, 255*self.life / self.maxl, 255*self.life / self.maxl, 5)
        #ellipse(self.loc.x, self.loc.y, self.radm * self.life / self.maxl, self.radm * self.life / self.maxl)
        #ellipse(self.loc.x, self.loc.y, 10, 10)
        if not self.jump:
            strokeWeight(3)
            #ellipse(self.loc.x, self.loc.y, self.radm * self.life / self.maxl, self.radm * self.life / self.maxl)
            #line(self.loc.x, self.loc.y, self.prev.x, self.prev.y)
            point(self.loc.x, self.loc.y)
            #ellipse(self.loc.x, self.loc.y, 10, 10)

def setup():
    global w, h, p, f
    smooth(4)
    colorMode(HSB)
    blendMode(ADD)
    size(500, 500)
    w = width
    h = height
    background(0)
    noStroke()
    
    f = build_field()
    p = [particle() for i in range(n)]
    

oz = 0
v = 1.1

def build_field():
    field = [[None for _ in range(width / side)] for _ in range(height / side)]
    oy = 0
    for i in range(height / side):
        ox = 0
        oy += inc
        for j in range(width / side):
            c = noise(ox, oy, oz) * TWO_PI
            field[i][j] = PVector.fromAngle(c * v).setMag(1)
            #stroke(255)
            #line((j+0.5)*side, (i+0.5)*side, (j+0.5)*side+side*cos(c*v), (i+0.5)*side+side*sin(c*v))
            ox += inc
    return field


def get_field(updt=False):
    global f, oz, v
    if updt:
        oz += inc
        f = build_field()
    return f



def draw():
    #background(0)
    field = get_field()
    
    for e in p:
        vector = field[min(floor(e.loc.y / side), len(field))][min(floor(e.loc.x / side), len(field[0]))]
        e.apply_force(vector)
        e.move()
            
            
def mousePressed():
    save('flow_field_6')
    print('done')
        
            
    
    
    
    
    
    
    
