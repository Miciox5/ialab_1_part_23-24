import pandas as pd
from clingo import Control 
from sys import argv


if len(argv) == 0:
    raise Exception("No file specified")

file = argv[1]

# Load the clingo control object
ctl = Control()

# Load the clingo program from a file
ctl.load(file)

# Ground the program
ctl.ground([("base", [])])

# Solve the program
model = ctl.solve(yield_=True, async_=True).model()

# Format the output (#show predicates)
formatted_output = ""
for show in model.symbols(shown=True):
    formatted_output += str(show) + "\n"
print(formatted_output)
