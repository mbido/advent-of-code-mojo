import aoc_utils as ut


fn should_be_alive(grid: ut.Grid, i: Int, j: Int) -> Bool:
    var c1 = Int(ut.char_code("#"))
    var c2 = Int(ut.char_code("."))

    var counter = 0
    for adj in ut.adj8:
        var x, y = adj
        if grid[i + x, j + y] == c1:
            counter += 1
    if grid[i, j] == Int(c2):
        return counter == 3
    return 2 <= counter <= 3

fn one_pass(before: ut.Grid, mut now: ut.Grid):
    var c1 = Int(ut.char_code("#"))
    var c2 = Int(ut.char_code("."))

    @parameter
    fn worker(index: Int):
        var i = index % before.width 
        var j = index // before.width

        if should_be_alive(before, i, j):
                now[i, j] = c1 
            else:
                now[i, j] = c2 

    ut.parallelize[worker](before.height * before.width)


fn count_alive(grid: ut.Grid) -> Int:
    var c1 = Int(ut.char_code("#"))

    var counter = 0
    for i in range(grid.width):
        for j in range(grid.height):
            if grid[i, j] == c1:
                counter += 1
    return counter

fn part1(data: String):
    var grid1: ut.Grid = ut.Grid(data)
    var grid2: ut.Grid = ut.Grid(data)

    for _ in range(50):
        one_pass(grid1, grid2)
        one_pass(grid2, grid1)
    
    print(count_alive(grid1))

fn set_corners(mut grid: ut.Grid):
    var c1 = Int(ut.char_code("#"))
    grid[0, 0] = c1
    grid[0, grid.height - 1] = c1
    grid[grid.width - 1, 0] = c1
    grid[grid.width - 1, grid.height - 1] = c1

fn part2(data: String):
    var grid1: ut.Grid = ut.Grid(data)
    var grid2: ut.Grid = ut.Grid(data)
    set_corners(grid1)

    for _ in range(500):
        one_pass(grid1, grid2)
        set_corners(grid2)
        one_pass(grid2, grid1)
        set_corners(grid1)

    print(count_alive(grid1))

def main():

    var data_file = open("/Users/matthieubidault/projects/advent-of-code/advent-of-code-mojo/aoc_2015/data/day_18.txt", "r")
    var data = data_file.read()
    data_file.close()

    # Start of the problem resolution
    print("Executing day 18...")
    var start = ut.perf_counter()

    print("--- part 1 ---")
    # part1(data)

    print("--- part 2 ---")
    part2(data)

    # End of problem resolution 
    print("Executed in: " + String(ut.perf_counter() - start) + "s")


