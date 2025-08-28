
import aoc_utils as ut

def main():

    data_file = open("../data/day_1.txt", "r")
    data = data_file.read()
    data_file.close()

    # Start of the problem resolution
    start = ut.perf_counter()
    print("Executing day 1...")


    # End of problem resolution 
    print("Executed in: " + String(ut.perf_counter() - start) + "s")
