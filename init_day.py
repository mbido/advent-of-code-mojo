"""
The Goal of this file is to initiate the file of the day for the advent of code.

By default, it will take the current day and year. You can specify a date when
executing the script : python init_day.py 2015 1

For the file to execute properly, you need to give your AOC session_cookie and
the input of that day must be available.

You can use a flag "--no_dl". it will ignore the session cookie and the input.
It will only create a file based on a set template.

Execute this script at the ROOT of the project !
"""

import sys
import os
import requests
import time
from datetime import date


PWD = os.getenv("PWD")


def get_cookie():
    cookie_file = f"{PWD}/session_cookie.txt"
    if os.path.exists(cookie_file):
        with open(cookie_file) as f:
            return f.read().strip()

    cookie = input("Insert session cookie : ").strip()
    with open(cookie_file, "w") as f:
        f.write(cookie)
    return cookie


def get_input(year, day):
    url = f"https://adventofcode.com/{year}/day/{day}/input"
    session_cookie = get_cookie()
    cookies = {"session": session_cookie}
    response = requests.get(url, cookies=cookies)
    return response.text[:-1:] if response.text[-1] == "\n" else response.text


def create_src_file(path, year, day, input_file):

    template = f"""import aoc_utils as ut

fn part1(data: String):
    print(data)


fn part2(data: String):
    print(data)

def main():

    data_file = open("{input_file}", "r")
    data = data_file.read()
    data_file.close()

    # Start of the problem resolution
    print("Executing day {day:02}...")
    start = ut.perf_counter()

    print("--- part 1 ---")
    part1(data)

    print("--- part 2 ---")
    # part2(data)

    # End of problem resolution 
    print("Executed in: " + String(ut.perf_counter() - start) + "s")
"""
    if os.path.exists(path):
        raise Exception(
            f"The source file for AOC {year} day {day:02} already exists. Please remove it before trying again."
        )

    with open(path, "w") as src_f:
        src_f.write(template)


def create_input_file(path, year, day):
    with open(path, "w") as data_f:
        data_f.write(get_input(year, day))


def ensure_utils_symlink(src_dir, project_root):
    target_abs = os.path.join(project_root, "aoc_utils.mojo")
    link_path = os.path.join(src_dir, "aoc_utils.mojo")

    if not os.path.exists(target_abs):
        return

    if os.path.lexists(link_path):
        return

    relative_target = os.path.relpath(target_abs, start=src_dir)
    try:
        os.symlink(relative_target, link_path)
    except OSError as e:
        print(
            f"Unable to create the symlink({e}). "
            f"Create it manually with : ln -s {relative_target} {link_path}"
        )


def create_file_from_template(extension, year, day, no_dl=False):

    root_dir = os.path.join(os.getcwd(), f"{PWD}/aoc_{year}")
    src_dir = root_dir + "/src"
    data_dir = root_dir + "/data"

    src_file = src_dir + f"/day_{day:02}{extension}"
    input_file = data_dir + f"/day_{day:02}.txt"

    if not os.path.exists(root_dir):
        os.makedirs(src_dir)
        os.makedirs(data_dir)
        ensure_utils_symlink(src_dir, os.getcwd())

    create_src_file(src_file, year, day, input_file)
    if not no_dl:
        create_input_file(input_file, year, day)


if __name__ == "__main__":
    argv = sys.argv
    no_dl = False
    if "--no_dl" in argv:
        argv.remove("--no_dl")
        no_dl = True
    argv = argv[1:]
    if len(argv) > 2:
        raise Exception("Too many arguments given!")

    today = date.today()
    current_year = today.year
    current_day = today.day
    current_month = today.month
    if len(argv) < 2:
        if current_month != 12:
            raise Exception(
                "This is not december! please give the year and the day of the AOC probleme you want to start."
            )
        if current_day > 25:
            raise Exception(
                "We passed the 25 of December! please give the year and the day of the AOC probleme you want to start."
            )
        create_file_from_template(".mojo", current_year, current_day, no_dl)
        exit()

    # len(argv) = 2
    year = int(argv[0])
    day = int(argv[1])

    if no_dl:
        create_file_from_template(".mojo", year, day, no_dl)
        exit()

    asked_date = time.strptime(f"{day}/12/{year}", "%d/%m/%Y")
    current_date = time.strptime(
        f"{current_day}/{current_month}/{current_year}", "%d/%m/%Y"
    )
    if not asked_date <= current_date:
        raise Exception("The problem you asked for is not avvailable yet.")

    if year < 2015 or day > 25 or day <= 0:
        raise Exception("The problem you asked for does not exist.")

    create_file_from_template(".mojo", year, day, no_dl)
