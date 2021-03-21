# Author: Shankar Veruva
# Date: 24th March 2019


def countStudentClass(studentScore_list):
    if len(studentScore_list) < 1:
        print("Please add at least 1 item into the list")
        return 0

    nerdCount_list = [0] * 7  # intialize the output list

    # Please write your own program here

    # Initializing value counter
    nerdScoreCounter = 0

    # Validating nerd scores in the list
    for nerdScore in studentScore_list:
        # Checking if int/float nerd score is passed which is less than zero
        if ((type(nerdScore) == int or type(nerdScore) == float) and nerdScore < 0):
            print("Nerd Score in position {0} of the student score list cannot be a negative number!".format(studentScore_list.index(nerdScore)), end=" ")
            print("Please enter correct details!")

        # Checking if valid nerd score value is passed as string
        elif type(nerdScore) == str:
            try:
                nerdScore = float(nerdScore)
                if nerdScore < 0:
                    print("Nerd Score in position {0} of the student score list cannot be a negative number!".format(studentScore_list.index(str(nerdScore))), end=" ")
                    print("Please enter correct details!")
                elif nerdScore >= 0:
                    nerdScoreCounter += 1
            except ValueError:
                print("Nerd Score in position {0} of the student score list is invalid!".format(studentScore_list.index(str(nerdScore))), end=" ")
                print("Please enter correct details!")

        # If all values seem valid, update counter value
        else:
            nerdScoreCounter += 1

    # To find the nerd rating frequency if all values in the list seem fine
    if nerdScoreCounter == len(studentScore_list):
        for nerdScore in studentScore_list:

            # For int/float nerd scores
            if (type(nerdScore) == int or type(nerdScore) == float) and nerdScore >= 0:
                if 0 <= nerdScore < 1:
                    nerdCount_list[0] += 1
                elif 1 <= nerdScore < 10:
                    nerdCount_list[1] += 1
                elif 10 <= nerdScore < 100:
                    nerdCount_list[2] += 1
                elif 100 <= nerdScore < 500:
                    nerdCount_list[3] += 1
                elif 500 <= nerdScore < 1000:
                    nerdCount_list[4] += 1
                elif 1000 <= nerdScore < 2000:
                    nerdCount_list[5] += 1
                elif nerdScore >= 2000:
                    nerdCount_list[6] += 1

            # For valid nerd score which is passed as a string
            elif type(nerdScore) == str:
                nerdScore = float(nerdScore)
                if 0 <= nerdScore < 1:
                    nerdCount_list[0] += 1
                elif 1 <= nerdScore < 10:
                    nerdCount_list[1] += 1
                elif 10 <= nerdScore < 100:
                    nerdCount_list[2] += 1
                elif 100 <= nerdScore < 500:
                    nerdCount_list[3] += 1
                elif 500 <= nerdScore < 1000:
                    nerdCount_list[4] += 1
                elif 1000 <= nerdScore < 2000:
                    nerdCount_list[5] += 1
                elif nerdScore >= 2000:
                    nerdCount_list[6] += 1

    # If there is one or more than one invalid entry, display a list of -1 to imply wrong inputs
    else:
        nerdCount_list = [-1] * 7

    return nerdCount_list


if __name__ == '__main__':

    # test cases
    # studentScore_list = []  #
    studentScore_list = [23, 76, 1300, 600]  # output should be [0, 0, 2, 0, 1, 1, 0]

    print(countStudentClass(studentScore_list))
