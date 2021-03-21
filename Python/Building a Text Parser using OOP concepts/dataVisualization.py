# Importing class Parser from parser_30513669.py
from parser_30513669 import Parser

# Importing required libraries
import numpy as np
import matplotlib.pyplot as plt


# Method to draw bar graph to visualize the distribution of the vocabulary size of all posts
# Inputs : inputFile (data.xml) and outputImage (wordNumberDistribution.png)
def visualizeWordDistribution(inputFile, outputImage):

    # Initializing variables to plot graph
    width = 20
    height = 20
    pixel = 160

    # To open data.xml file
    input_handle = open(inputFile, "r", encoding="utf-8")

    # Setting x axis (vocabulary range)
    vocabularyRange = ('0-9', '10-19', '20-29', '30-39', '40-49', '50-59', '60-69', '70-79', '80-89', '90-99', 'Others')
    lenOfVocabularyRange = np.arange(len(vocabularyRange))

    # Initializing noOfLines list to store total number of lines per vocabulary range
    noOfLines = [0] * lenOfVocabularyRange

    for line in input_handle:
        parseLine = Parser(line)
        if parseLine.getID() != "":
            vocabularySize = parseLine.getVocabularySize()
            if 0 <= vocabularySize <= 9:
                noOfLines[0] += 1
            elif 10 <= vocabularySize <= 19:
                noOfLines[1] += 1
            elif 20 <= vocabularySize <= 29:
                noOfLines[2] += 1
            elif 30 <= vocabularySize <= 39:
                noOfLines[3] += 1
            elif 40 <= vocabularySize <= 49:
                noOfLines[4] += 1
            elif 50 <= vocabularySize <= 59:
                noOfLines[5] += 1
            elif 60 <= vocabularySize <= 69:
                noOfLines[6] += 1
            elif 70 <= vocabularySize <= 79:
                noOfLines[7] += 1
            elif 80 <= vocabularySize <= 89:
                noOfLines[8] += 1
            elif 90 <= vocabularySize <= 99:
                noOfLines[9] += 1
            elif vocabularySize >= 100:
                noOfLines[10] += 1

    input_handle.close()        # To close data.xml file

    # Setting size and dpi of the graph
    plt.figure(figsize=(width, height), dpi=pixel)

    # Plotting bar graph vocabulary size vs number of posts in a range
    plt.bar(lenOfVocabularyRange, noOfLines, align='center')
    plt.xticks(lenOfVocabularyRange, vocabularyRange, rotation=30)
    plt.ylabel('Number Of Posts Within Vocabulary Size')
    plt.xlabel('Vocabulary Size')
    plt.title('Vocabulary Size Distribution')

    # Saving the output image file into wordNumberDistribution.png
    plt.savefig(outputImage)

    # Clear the plot so that next graph can be displayed without overlapping
    plt.clf()


# Method to display trend of the post numbers in the Q&A site
# Inputs : inputFile (data.xml) and outputImage (postNumberTrend.png)
def visualizePostNumberTrend(inputFile, outputImage):

    # Initializing variables to plot graph
    width = 20
    height = 20
    pixel = 160

    # Initializing quarter year list
    quarter = []

    # Setting x axis (year - quarter)
    quarter = ['2015Q2', '2015Q3', '2015Q4', '2016Q1', '2016Q2', '2016Q3', '2016Q4', '2017Q1', '2017Q2', '2017Q3', '2017Q4', \
               '2018Q1', '2018Q2', '2018Q3', '2018Q4', '2019Q1', '2019Q2', '2019Q3', '2019Q4']

    question = [0] * len(quarter)
    answer = [0] * len(quarter)


    input_handle = open(inputFile, "r", encoding="utf-8")  # To open data.xml file
    for line in input_handle:
        parseLine = Parser(line)
        if parseLine.getID() != "":
            if parseLine.getPostType() == '1':
                question[quarter.index(parseLine.getDateQuarter())] += 1
            elif parseLine.getPostType() == '2':
                answer[quarter.index(parseLine.getDateQuarter())] += 1

    input_handle.close()        # To close data.xml file

    # Setting size and dpi of the graph
    plt.figure(figsize=(width, height), dpi=pixel)

    # Plotting line chart to annotate the number of posts in each quarter
    plt.plot(quarter, question, color='green', label='Question')
    plt.plot(quarter, answer, color='orange', label='Answer')
    plt.xlabel('Year - Quarter')
    plt.ylabel('Number Of Questions and Answers')
    plt.title('Post Number Trend')
    plt.legend()

    # Saving the output image file into postNumberTrend.png
    plt.savefig(outputImage)

    # Clear the plot so that next graph can be displayed without overlapping
    plt.clf()


if __name__ == "__main__":
    f_data = "data.xml"
    f_wordDistribution = "wordNumberDistribution.png"
    f_postTrend = "postNumberTrend.png"

    visualizeWordDistribution(f_data, f_wordDistribution)
    visualizePostNumberTrend(f_data, f_postTrend)
