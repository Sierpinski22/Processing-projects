gravity = PVector(0, 0.02)
r = 2
n = 8
radius = None
particles = []
cx, cy = None, None
f = None
df = None


class particle:
    def __init__(self, x, y, m=1, vx=0, vy=0, h=100):
        self.loc = PVector(x, y)
        self.vel = PVector(vx, vy)
        self.mss = m
        self.h = h
     
    def force(self, f):
        self.vel.add(f / self.mss)
    
    def bounce(self, cx, cy):
        if self.loc.dist(PVector(cx, cy)) >= radius / 2 - r:
            ac = atan2((self.loc.y-cy), (self.loc.x-cx))
            magnitude = self.vel.mag()
            angle = -self.vel.heading() + 2*ac + PI
            self.vel = magnitude * PVector(cos(angle), sin(angle))
            self.loc = PVector(cx+(radius/2 - r)*cos(ac), cy+(radius/2 - r)*sin(ac))

    def correct_trajectory(self, cx, cy):
        if self.loc.dist(PVector(cx, cy)) > radius / 2 - r:
            ac = atan2((self.loc.y-cy), (self.loc.x-cx))
            self.loc = PVector(cx+(radius/2 - r)*cos(ac), cy+(radius/2 - r)*sin(ac))

    def move(self, cx, cy):
        prev = self.loc.copy()
        self.bounce(cx, cy)
        self.force(gravity)
        self.loc.add(self.vel)
        self.correct_trajectory(cx, cy)
        stroke(self.h, 300, 250)
        strokeWeight(3)
        line(prev.x, prev.y, self.loc.x, self.loc.y)
    
    def show(self):
        fill(self.h, 300, 300)
        noStroke()
        circle(self.loc.x, self.loc.y, r)
        
        
def setup():
    colorMode(HSB)
    blendMode(ADD)
    global radius, particles, cx, cy
    size(700, 700)
    smooth(4)
    radius = width / 5 * 4
    cx, cy = width / 2, height / 2
    inc = float(n) / 20

    for i in range(floor(n/2)):
        if n % 2 == 1 and i == 0:
            particles.append(particle(cx, cy / 3.5, h=0))
        particles.append(particle(cx - 0.1*(i+1), cy / 3.5, h=0))
        particles.append(particle(cx + 0.1*(i+1), cy / 3.5, h=0))
    
    for i, p in enumerate(particles):
        p.h = 255 * (float(i) / float(n))
        
    background(0)
    noFill()
    stroke(255)
    circle(cx, cy, radius)
    
def draw():
    if frameCount % 10 == 0:
        if frameCount % 10000 == 0:
            saveFrame('picture2.jpg')
        fill(0, 0, 0, 0)
        rect(0, 0, width, height)
    
    for p in particles:
        p.move(cx, cy)
        p.show()
