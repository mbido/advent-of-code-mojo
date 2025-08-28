import aoc_utils as ut

fn part1(data: String):
    print(data)


fn part2(data: String):
    print(data)

def main():

    data_file = open("/Users/matthieubidault/projects/advent-of-code/advent-of-code-mojo/aoc_2015/data/day_02.txt", "r")
    data = data_file.read()
    data_file.close()

    # Start of the problem resolution
    print("Executing day 02...")
    start = ut.perf_counter()

    print("--- part 1 ---")
    part1(data)

    print("--- part 2 ---")
    # part2(data)

    # End of problem resolution 
    print("Executed in: " + String(ut.perf_counter() - start) + "s")
