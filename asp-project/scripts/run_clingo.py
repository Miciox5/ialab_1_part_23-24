import clingo_dl

def main():
    # Create a control object
    control = clingo.Control()

    # Load the Clingo file
    control.load("campionato-20squadre.cl")

    # Ground the program
    control.ground([("base", [])])

    # Solve the problem
    answer_sets = []
    for model in control.solve().models:
        answer_sets.append(model)

    # Print the answer sets
    for answer_set in answer_sets:
        print(answer_set)

if __name__ == "__main__":
    main()