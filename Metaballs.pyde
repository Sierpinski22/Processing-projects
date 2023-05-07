balls = None
n = 4
tr = 1
side = 20
l = True

class mball:
    def __init__(self, x, y):
        self.loc = PVector(x, y)
        self.vel = PVector(random(3, 5), random(3, 5))
        self.r = ceil(random(1) * 20 + 20)
        
    def edge(self):
        if self.loc.x < self.r / 2 or self.loc.x > width - self.r / 2:
            self.vel.x = -self.vel.x
        if self.loc.y < self.r / 2 or self.loc.y > height - self.r / 2:
            self.vel.y = -self.vel.y
   
    def move(self):
         self.loc.add(self.vel)
         self.edge()
    
    def show(self):
        circle(self.loc.x, self.loc.y, self.r)
        


def lin_int(x0, x1, v0, v1, s=tr):
    return x0 + (s-v0) / (v1 - v0) * (x1-x0)


def march(c, threshold=tr, s=side, lin=False):
    if type(c[0][0]) != type([]):
        c = [c]
    
    for y in range(rows - 1):
        for x in range(cols - 1):
            for i, canv in enumerate(c):
                if i == 0:
                    stroke(0, 255, 0)
                elif i == 1:
                    stroke(255, 0, 0)
                elif i == 2:
                    stroke(0, 0, 255)
                
                p = [None, None, None, None]
                
                p[0] = PVector(lin_int(x*s, x*s+s, canv[y][x], canv[y][x+1]) if lin else x*s + s/2, y*s) if (canv[y][x] > threshold and canv[y][x+1] < threshold) or (canv[y][x] < threshold and canv[y][x+1] > threshold) else None
                p[1] = PVector(x*s, lin_int(y*s, y*s+s, canv[y][x], canv[y+1][x]) if lin else y*s + s/2) if (canv[y][x] > threshold and canv[y+1][x] < threshold) or (canv[y][x] < threshold and canv[y+1][x] > threshold) else None
                p[2] = PVector(x*s + s, lin_int(y*s, y*s+s, canv[y][x+1], canv[y+1][x+1]) if lin else y*s + s/2) if (canv[y][x+1] > threshold and canv[y+1][x+1] < threshold) or (canv[y][x+1] < threshold and canv[y+1][x+1] > threshold) else None
                p[3] = PVector(lin_int(x*s, x*s+s, canv[y+1][x], canv[y+1][x+1]) if lin else x*s + s/2, y*s + s) if (canv[y+1][x] > threshold and canv[y+1][x+1] < threshold) or (canv[y+1][x] < threshold and canv[y+1][x+1] > threshold) else None

                pr = [e for e in p if e is not None]
                if len(pr) == 4:
                    if canv[y][x] > threshold:
                        line(pr[0].x, pr[0].y, pr[1].x, pr[1].y)
                        line(pr[3].x, pr[3].y, pr[2].x, pr[2].y)
                    else:
                        line(pr[0].x, pr[0].y, pr[2].x, pr[2].y)
                        line(pr[3].x, pr[3].y, pr[1].x, pr[1].y)
                elif len(pr) == 2:
                    line(pr[0].x, pr[0].y, pr[1].x, pr[1].y)
                

def setup():
    global balls, cols, rows
    size(600, 600)
    background(0)
    noFill()
    
    cols, rows = width / side + 1, height / side + 1
    balls = []

    for i in range(n):
        balls.append(mball(random(40, width - 40), random(40, height - 40)))
    
    
def draw():
    background(0)
    grid = [[0 for _ in range(cols)] for _ in range(rows)]
    grid2 = [[0 for _ in range(cols)] for _ in range(rows)]
    grid3 = [[0 for _ in range(cols)] for _ in range(rows)]
    
    for b in balls:
        b.move()
        
    for y in range(rows):
        for x in range(cols):
            for b in balls:
                
                grid[y][x] += 1 / dist(b.loc.x, b.loc.y, x*side, y*side) * b.r * 1.1
                grid2[y][x] = grid[y][x] / 1.5
                grid3[y][x] = grid2[y][x] / 1.5
            
            #noStroke()
            #fill(grid[y][x] * 200)
            #rect(x*side, y*side, side, side)
        
                
    march([grid, grid2, grid3], lin=l)

    
def mousePressed():
    global l
    l = not l
