# Author: Shankar Veruva
# Date: 24th March 2019


# Functionality: cailculate the skill score by the equation
# x, y, z are inputs
def calculateSkillEquation(FandomScore, HobbiesScore, SportsNum):
    skillScore = 0  # intialize the output list

    # Please write your own program here

    # Importing math library
    import math

    # Initializing value flags
    fandomScoreFlag = False
    hobbiesScoreFlag = False
    numberOfSportsPlayedFlag = False

    ##### Validating Fandom Score ####

    # Checking if value is passed as int
    if type(FandomScore) == int:
        if FandomScore > 0:
            fandomScoreFlag = True
        elif FandomScore == 0:
            print("Fandom score cannot be a zero. Please enter positive integer!")
        elif FandomScore < 0:
            print("Fandom score cannot be a negative number. Please enter positive integer!")

    # Checking if integer value is passed as string
    elif type(FandomScore) == str:
        try:
            FandomScore = int(FandomScore)
            if FandomScore > 0:
                fandomScoreFlag = True
            elif FandomScore == 0:
                print("Fandom score cannot be a zero. Please enter positive integer!")
            elif FandomScore < 0:
                print("Fandom score cannot be a negative number. Please enter positive integer!")
        except ValueError:
            print("Fandom score can be a positive integer only. Please enter accordingly!")

    # Checking if value is passed as float and mantissa as 0 ; ex: 4.00
    elif type(FandomScore) == float and FandomScore.is_integer():
        FandomScore = int(FandomScore)
        if FandomScore > 0:
            fandomScoreFlag = True
        elif FandomScore == 0:
            print("Fandom score cannot be a zero. Please enter positive integer!")
        elif FandomScore < 0:
            print("Fandom score cannot be a negative number. Please enter positive integer!")

    # If value isn't in form of int, string(as digits) or float(with mantissa 0), invalid score!
    else:
        print("Fandom score can be a positive integer only. Please enter accordingly!")


    #### Validating Hobbies Score ####

    # Checking if value is passed as int
    if type(HobbiesScore) == int:
        if HobbiesScore % 4 == 0 and HobbiesScore >= 0:
            hobbiesScoreFlag = True
        elif HobbiesScore < 0:
            print("Hobbies score cannot be a negative number. Please enter zero or positive integer multiple of 4!")
        elif HobbiesScore % 4 != 0:
            print("Hobbies score cannot be a non-multiple of 4. Please enter zero or positive integer multiple of 4!")

    # Checking if integer value is passed as string
    elif type(HobbiesScore) == str:
        try:
            HobbiesScore = int(HobbiesScore)
            if HobbiesScore % 4 == 0 and HobbiesScore >= 0:
                hobbiesScoreFlag = True
            elif HobbiesScore < 0:
                print("Hobbies score cannot be a negative number. Please enter zero or positive integer multiple of 4!")
            elif HobbiesScore % 4 != 0:
                print("Hobbies score cannot be a non-multiple of 4. Please enter zero or positive integer multiple of 4!")
        except ValueError:
            print("Hobbies score can be zero or positive integer multiple of 4 only. Please enter accordingly!")

    # Checking if value is passed as float and mantissa as 0 ; ex: 4.00
    elif type(HobbiesScore) == float and HobbiesScore.is_integer():
        HobbiesScore = int(HobbiesScore)
        if HobbiesScore % 4 == 0 and HobbiesScore >= 0:
            hobbiesScoreFlag = True
        elif HobbiesScore < 0:
            print("Hobbies score cannot be a negative number. Please enter zero or positive integer multiple of 4!")
        elif HobbiesScore % 4 != 0:
            print("Hobbies score cannot be a non-multiple of 4. Please enter zero or positive integer multiple of 4!")

    # If value isn't in form of int, string(as digits) or float(with mantissa 0), invalid score!
    else:
        print("Hobbies score can be zero or positive integer multiple of 4 only. Please enter accordingly!")


    #### Validating Number of Sports Played ####

    # Checking if value is passed as int
    if type(SportsNum) == int:
        if SportsNum >= 0:
            numberOfSportsPlayedFlag = True
        elif SportsNum < 0:
            print("Number of sports played cannot be a negative number. Please enter zero or positive integer!")

    # Checking if integer value is passed as string
    elif type(SportsNum) == str:
        try:
            SportsNum = int(SportsNum)
            if SportsNum >= 0:
                numberOfSportsPlayedFlag = True
            elif SportsNum < 0:
                print("Number of sports played cannot be a negative number. Please enter zero or positive integer!")
        except ValueError:
            print("Number of sports played can be zero or positive integer only. Please enter accordingly!")

    # Checking if value is passed as float and mantissa as 0 ; ex: 4.00
    elif type(SportsNum) == float and SportsNum.is_integer():
        SportsNum = int(SportsNum)
        if SportsNum >= 0:
            numberOfSportsPlayedFlag = True
        elif SportsNum < 0:
            print("Number of sports played cannot be a negative number. Please enter zero or positive integer!")

    # If value isn't in form of int, string(as digits) or float(with mantissa 0), invalid score!
    else:
        print("Number of sports played can be zero or positive integer only. Please enter accordingly!")


    #### Calculating Nerd Score ####
    if fandomScoreFlag and hobbiesScoreFlag and numberOfSportsPlayedFlag:
        skillScore = FandomScore * math.sqrt((42 * (HobbiesScore ** 2)) / (SportsNum + 1))
    else:
        skillScore = -1  # Skill Score = -1 if any of the parameters required to calculate the score is wrong/missing!

    return skillScore


if __name__ == '__main__':
    FandomScore, HobbiesScore, SportsNum = 1, 4, 1  # the output should be 18.33030277982336

    print(calculateSkillEquation(FandomScore, HobbiesScore, SportsNum))
