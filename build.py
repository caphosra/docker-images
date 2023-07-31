#!/usr/bin/python3

import glob
from pathlib import Path
import re
import os
import sys
import subprocess

regex = re.compile(r'^#+\s([A-Z]+)!\s(.+)$')
is_generated = re.compile(r'^.*\.gen$')

def clean():
    for file in glob.glob("./**/*.gen.dockerfile"):
        os.remove(file)
    print("Deleted all generated files.")

def resolve(file, indent = 0) -> str:
    if is_generated.match(file):
        return

    def log(text) -> None:
        print(("" if indent == 0 else ">" * indent + " ") + text)

    file_path = Path(f"{file}.dockerfile")
    output_path = f"{file_path.parent}/{file_path.stem}.gen.dockerfile"

    if os.path.exists(output_path):
        log(f"Already processed {file}.")
        return output_path

    log(f"Processing {file}...")

    with open(file_path, "r") as input_fs:
        with open(output_path, "w") as out_fs:
            for line in input_fs.readlines():
                match = regex.match(line[0:-1])
                if match:
                    command = match.group(1)
                    arg = match.group(2)
                    if command == "INSERT":
                        output_path = resolve(arg, indent=indent + 1)
                        with open(output_path, "r") as resolved_fs:
                            out_fs.writelines(resolved_fs.readlines())
                            out_fs.write("\n")
                    elif command == "EXEC":
                        output = subprocess.run(arg, stdout=subprocess.PIPE, shell=True).stdout.decode()
                        out_fs.write(f"{output}\n")
                else:
                    out_fs.write(line)

    return output_path

def resolve_all():
    for file in glob.glob("./**/*.dockerfile"):
        file_path = Path(file)
        resolve(f"{file_path.parent}/{file_path.stem}")

if __name__ == '__main__':
    if len(sys.argv) == 2:
        arg = sys.argv[1]
        if arg == "clean":
            clean()
        elif arg == "all":
            resolve_all()
        else:
            resolve(arg)
    else:
        print("The number of arguments must be 1.")
