# Author: Shankar Veruva
# Date: 24th March 2019


#Please write your own program here

# Importing math library
import math

# Initializing required variables
choice = " "
fandomScore = 0
hobbiesScore = 0
numberOfSportsPlayed = 0
nerdScore = 0.0
findClass = " "

# Initializing loop flags
outerFlag = True
innerFlag = True

# Initializing value flags
fandomScoreFlag = False
hobbiesScoreFlag = False
numberOfSportsPlayedFlag = False
nerdScoreFlag = False

# Displaying the menu
while outerFlag:
    innerFlag = True
    print("\n1.Fandom Score\n2.Hobbies Score\n3.Sports Score\n4.Calculate Nerd Score")
    print("5.Print Nerd Rating of Student\n6.Exit\n")  # Broke the print statement into two as line was > 120 characters
    choice = input("What would you like to do? ")

    if choice == "1":           # To enter fandom score
        while innerFlag:
            fandomScore = input("\nEnter number of things you are a fan of : ")
            try:
                fandomScore = int(fandomScore)
                # Validating the input
                if fandomScore > 0:
                    innerFlag = False
                    fandomScoreFlag = True
                elif fandomScore < 0:
                    print("Fandom score cannot be a negative number. Please enter again!\n")
                else:
                    print("Fandom score cannot be zero. Please enter again!\n")
            except ValueError:
                print("Fandom score can be a positive integer only. Please enter again!\n")

    elif choice == "2":         # To enter hobbies score
        while innerFlag:
            hobbiesScore = input("\nEnter number of hobbies on a weekly basis : ")
            try:
                hobbiesScore = int(hobbiesScore)
                # Validating the input
                if hobbiesScore >= 0 and hobbiesScore % 4 == 0:
                    innerFlag = False
                    hobbiesScoreFlag = True
                elif hobbiesScore < 0:
                    print("Hobbies score cannot be a negative number. Please enter again!\n")
                elif hobbiesScore % 4 != 0:
                    print("Hobbies score has to be a multiple of 4. Please enter again!\n")
            except ValueError:
                print("Hobbies score can be zero or positive integer only. Please enter again!\n")

    elif choice == "3":             # Enter number of sports played
        while innerFlag:
            numberOfSportsPlayed = input("\nEnter number of sports items you own : ")
            try:
                numberOfSportsPlayed = int(numberOfSportsPlayed)
                # Validating the input
                if numberOfSportsPlayed >= 0:
                    innerFlag = False
                    numberOfSportsPlayedFlag = True
                elif numberOfSportsPlayed < 0:
                    print("Number of sports items owned cannot be a negative number. Please enter again!\n")
            except ValueError:
                print("Number of sports played can be zero or positive integer only. Please enter again!\n")

    elif choice == "4":             # To calculate the nerd score
        # Checking if Fandom score, Hobbies score and number of sports played are given as inputs
        if fandomScoreFlag and hobbiesScoreFlag and numberOfSportsPlayedFlag:
            nerdScore = fandomScore * math.sqrt((42*(hobbiesScore**2))/(numberOfSportsPlayed+1))
            # Setting flag values for further validations
            nerdScoreFlag = True
            fandomScoreFlag = False
            hobbiesScoreFlag = False
            numberOfSportsPlayedFlag = False
            print("Nerd Score of the student is ", nerdScore)   # Printing nerd score
        else:
            nerdScoreFlag = False
            if fandomScoreFlag is False:
                print("Fandom score is missing. Please enter all the details!")
            if hobbiesScoreFlag is False:
                print("Hobbies score is missing. Please enter all the details!")
            if numberOfSportsPlayedFlag is False:
                print("Number of sports played entry is missing. Please enter all the details!\n")

    elif choice == "5":             # To display the class
        # Checking in which range does the Nerd Score fall
        if nerdScoreFlag:
            if 0 <= nerdScore < 1:
                findClass = "Nerdlite"
            elif 1 <= nerdScore < 10:
                findClass = "Nerdling"
            elif 10 <= nerdScore < 100:
                findClass = "Nerdlinger"
            elif 100 <= nerdScore < 500:
                findClass = "Nerd"
            elif 500 <= nerdScore < 1000:
                findClass = "Nerdington"
            elif 1000 <= nerdScore < 2000:
                findClass = "Nerdrometa"
            elif nerdScore >= 2000:
                findClass = "Nerd Supreme"
            print("Nerd Class of the student is ", findClass, "\n")     # Printing nerd class
            nerdScoreFlag = False
        else:
            print("Nerd Score isn't calculated.Please enter Fandom score, Hobbies score and Number of sports played!\n")

    elif choice == "6":  # Exit the loop/program
        break

    else:
        print("Invalid choice. Please try again\n")
