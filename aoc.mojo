'''AOC API
## Getting an input :

url = "https://adventofcode.com/{}/day/{}/input".format(year, day)
session_cookie = get_cookie()
cookies = {"session": session_cookie}
'''
# from dotenv import load_dotenv
from python import Python
from os import setenv, getenv, path
from sys import argv
from python import Python

alias ROOT_WD = String("/Users/matthieubidault/projects/advent-of-code/advent-of-code-mojo")

def get_cookie() -> String:
    Python.add_to_path(String("ROOT_WD"))
    rq = Python.import_module("request")
    var cookie_file : String = String("{!s}/cookie_file.txt").format(ROOT_WD)
    # print(cookie_file)
    # print(path.exists(cookie_file))
    # if not path.exists(cookie_file):
    #     var session_cookie = input("Enter your aoc session cookie : ")
    #     print(session_cookie)
    # print(cookie_file)
    # if os.path.exists(cookie_file):
    #     with open(cookie_file) as f:
    #         return f.read().strip()
    # else:
    #     cookie = input("Veuillez entrer votre cookie de session : ").strip()
    #     with open(cookie_file, "w") as f:
    #         f.write(cookie)
    #     return cookie
    return 'NONE'




def main():
    print("Hello AOC!")
    var unused = get_cookie()