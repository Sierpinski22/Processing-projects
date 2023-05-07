n = 16
side = 4

grid = None
grid1d = None
active = None
cube = None
cube1d = None



def find_shape(a):
    r = a**0.5
    divs = []
    if (r * 10) % 10 == 0:
        return (r, r)
    else:
        for i in range(1, ceil(r)):
            if a % i == 0:
                divs.append((i, a/i))

    return divs[-1]

c1, c2 = find_shape(n)


c = lambda x=n: floor(random(0, x))
pick = lambda v: v[c(len(v))]


def next_step(): #lista con posizioni accettabili, lista con colori accettabili, scelta casuale
    global active, cube, cube1d, grid, grid1d
    current = active.pop(0)
    r, g, b, x, y = current
    
    #1: lista posizioni accettabili
    pos = []
    
    if x+1 < len(grid[0]):
        if grid[y][x+1] is None:
            pos.append((x+1, y))
    if x-1 >= 0:
        if grid[y][x-1] is None:
            pos.append((x-1, y))
    if y+1 < len(grid):
        if grid[y+1][x] is None:
            pos.append((x, y+1))
    if y-1 >= 0:
        if grid[y-1][x] is None:
            pos.append((x, y-1))
    
    col = []
    i = 1
    if r+i < n:
        if not cube[r+i][g][b] is None:
            col.append((r+i, g, b))    
    if g+i < n:
        if not cube[r][g+i][b] is None:
            col.append((r, g+i, b))
    if b+i < n:
        if not cube[r][g][b+i] is None:
            col.append((r, g, b+i))
    i = -1
    if r+i >= 0:
        if not cube[r+i][g][b] is None:
            col.append((r+i, g, b))   
    if g+i >= 0:
        if not cube[r][g+i][b] is None:
            col.append((r, g+i, b))
    if b+i >= 0:
        if not cube[r][g][b+i] is None:
            col.append((r, g, b+i))
            
    ##################################
    if len(pos) == 0 or len(col) == 0:
        return
    else:
        active.insert(0, current)
    ###################################
    
    #3: scelta casuale
    position = pick(pos)
    colpos = pick(col)
    
    
    x, y = position
    r, g, b = colpos
    colour = cube[r][g][b]
    
    active.insert(0, (r, g, b, x, y))
    grid[y][x] = colour
    grid1d.remove((x, y))
    cube[r][g][b] = None
    cube1d.remove((colour, r, g, b))
    
    
    c1, c2, c3  = colour
    fill(c1, c2, c3)
    rect(x*side, y*side, side, side)
    #print(cube1d, len(grid1d))
           

def build_cube(num=n):
    inc = 256 / num
    cube = [[[(r*inc, g*inc, b*inc) for r in range(num)] for g in range(num)] for b in range(num)]
    cube1d = []
    for r in range(num):
        for g in range(num):
            for b in range(num):
                cube1d.append((cube[r][g][b], r, g, b))
    
    print("3D RGB cube built with size: {}x{}x{}x{}, 1D RGB vector with size: {}x{}".format(len(cube), len(cube[0]), len(cube[0][0]), len(cube[0][0][0]), len(cube1d), len(cube1d[0])))
    return cube, cube1d
    

def setup(): #4096
    global grid, grid1d, active, cube, cube1d
    size(int(n * side * c2), int(n * side * c1))
    noStroke()
    background(0)
    #noLoop()
    cube, cube1d = build_cube()
    grid = [[None for _ in range(width / side)] for _ in range(height / side)]
    grid1d = []
    for y in range(height / side):
        for x in range(width / side):
            grid1d.append((x, y))
    
    active = []
    
    # pick random cell and random color
    r, g, b = c(), c(), c()
    x, y = c(width/side), c(height/side)
    
    grid[y][x] = cube[r][g][b]
    grid1d.remove((x, y))
    cube1d.remove((cube[r][g][b], r, g, b))
    cube[r][g][b] = None
    active.append((r, g, b, x, y))
    fill(grid[y][x][0], grid[y][x][1], grid[y][x][2])
    square(x*side, y*side, side)
    
    
def draw():
    global active
    print(grid)
    if len(active)>0:
        next_step()
    elif len(cube1d) > 0:
        co = cube1d.pop(c(len(cube1d)))
        po = grid1d.pop(c(len(grid1d)))
        #print(co)
        colour, p1, p2, p3 = co
        #print(p1, p2, p3)
        r, g, b = colour
        x, y = po
        
        
        #print(cube[p1][p2][p3], colour)
        
        cube[p1][p2][p3] = None
        grid[y][x] = colour
        active.append((p1, p2, p3, x, y))
        
        
        fill(r, g, b)
        square(x*side, y*side, side)
    else:
        noLoop()
        print('done')
        saveFrame('one')
        
            
            
   #if len(pos) == 0 or len(col) == 0:
   #     return
   # elif len(pos) == 1 or len(col) == 1:
   #     if len(active) > 0:
   #         s = active.pop(c(len(active)))
   #         active.insert(0, s)
   # elif len(pos) > 1 and len(col) > 1:
   #     active.insert(0, current)
    
    
