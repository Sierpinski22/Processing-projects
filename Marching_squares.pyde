side = 20
inc = 0.1
zoff = 0
show = False
tr = 0.5


def lin_int(x0, x1, v0, v1, s=tr):
    return x0 + (s-v0) / (v1 - v0) * (x1-x0)


def march(canv, threshold=tr, s=side):
    stroke(0, 255, 0)
    p = [None, None, None, None]
    for y in range(len(canv) - 1):
        for x in range(len(canv[0]) - 1):
            p[0] = PVector(lin_int(x*s, x*s+s, grid[y][x], grid[y][x+1]), y*s) if (grid[y][x] > threshold and grid[y][x+1] < threshold) or (grid[y][x] < threshold and grid[y][x+1] > threshold) else None
            p[1] = PVector(x*s, lin_int(y*s, y*s+s, grid[y][x], grid[y+1][x])) if (grid[y][x] > threshold and grid[y+1][x] < threshold) or (grid[y][x] < threshold and grid[y+1][x] > threshold) else None
            p[2] = PVector(x*s + s, lin_int(y*s, y*s+s, grid[y][x+1], grid[y+1][x+1])) if (grid[y][x+1] > threshold and grid[y+1][x+1] < threshold) or (grid[y][x+1] < threshold and grid[y+1][x+1] > threshold) else None
            p[3] = PVector(lin_int(x*s, x*s+s, grid[y+1][x], grid[y+1][x+1]), y*s + s) if (grid[y+1][x] > threshold and grid[y+1][x+1] < threshold) or (grid[y+1][x] < threshold and grid[y+1][x+1] > threshold) else None

            pr = [e for e in p if e is not None]
           
            if len(pr) == 4:
                if grid[y][x] > threshold:
                    line(pr[0].x, pr[0].y, pr[1].x, pr[1].y)
                    line(pr[3].x, pr[3].y, pr[2].x, pr[2].y)
                else:
                    line(pr[0].x, pr[0].y, pr[2].x, pr[2].y)
                    line(pr[3].x, pr[3].y, pr[1].x, pr[1].y)
            elif len(pr) == 2:
                line(pr[0].x, pr[0].y, pr[1].x, pr[1].y)
                

    
def mousePressed():
    global show
    show = not show
        
                

def setup():
    global grid, rows, cols
    size(600, 600)
    cols, rows = width / side + 1, height / side + 1
    grid = [[None for _ in range(cols)] for _ in range(rows)]
    
    
def draw():
    global grid, zoff
    #background(0)
    
    yoff = 0
    for y in range(rows):
        yoff += inc
        xoff = 0
        for x in range(cols):
            xoff += inc
            grid[y][x] = noise(xoff, yoff, zoff)
            noStroke()
            fill(grid[y][x] * 255)
            square(x*side, y*side, side)
            
    zoff += inc/10
    if show:
        march(grid)
    #noLoop()
