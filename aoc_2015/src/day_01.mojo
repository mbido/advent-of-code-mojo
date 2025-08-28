import aoc_utils as ut

fn part1(data: String):
    print(data.count("(") - data.count(")"))


fn part2(data: String):
    floor: Int = 0
    index = 0
    for char in data.codepoint_slices():
        index += 1
        if floor < 0:
            print(index)
            return

        if char == "(":
            floor += 1
        else:
            floor -= 1

def main():

    data_file = open("../data/day_1.txt", "r")
    data = data_file.read()
    data_file.close()

    # Start of the problem resolution
    print("Executing day 1...")
    start = ut.perf_counter()

    print("--- part 1 ---")
    part1(data)

    print("--- part 2 ---")
    part2(data)

    # End of problem resolution 
    print("Executed in: " + String(ut.perf_counter() - start) + "s")
