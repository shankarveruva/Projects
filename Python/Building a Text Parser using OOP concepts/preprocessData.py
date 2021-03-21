# Importing required libraries
import os
import re

# Method to preprocess the line that is read from data.xml file
# Input : inputLine (string)
def preprocessLine(inputLine):

    # Initializing required flag value
    signFlag = True

    # Initializing character reference transformation dictionary
    characterReferenceTransformation = dict()

    # Setting key-value pair for dictionary
    characterReferenceTransformation = {'&amp;': '&', '&quot;': '"', '&apos;': '\'', '&gt;': '>', '&lt;': '<', '&#xA;': ' ', '&#xD;': ' '}

    # Replace the keys with values in inputLine
    while signFlag:
        signFlag = any(sign in inputLine for sign, value in characterReferenceTransformation.items())
        if signFlag is True:
            for sign, value in characterReferenceTransformation.items():
                inputLine = inputLine.replace(sign, value)

    # Using re library functionality to remove xml/html tags
    clean = re.compile('<.*?>')
    inputLine = re.sub(clean, '', inputLine)

    # Stripping the excess spaces in the inputLine after preprocessing
    inputLine = inputLine.strip()

    # Returning the processed inputLine
    return inputLine



# Splitting the inputFile into output question and answer file
# Inputs : inputFile(data.xml),outputFile_question(question.txt),outputFile_answer(answer.txt)-> string data type
def splitFile(inputFile, outputFile_question, outputFile_answer):

    input_handle = open(inputFile, "r", encoding="utf-8")               # To open data.xml file in read mode
    questionFile = open(outputFile_question, "a", encoding="utf-8")     # To open question.txt file in append mode
    answerFile = open(outputFile_answer, "a", encoding="utf-8")         # To open answer.txt file in append mode

    for line in input_handle:
        # Search for row id in data.xml file
        row = re.search('row Id="(.*?)"', line)
        if row is not None:
            # Search for post type id to determine if entry is a question or an answer
            postType = re.search('PostTypeId="(.*?)"', line)
            postType = postType.group(1).strip()

            # Search for body/content and pass it to preprocessLine method
            body = re.search('Body="(.*?)" />', line)
            body = body.group(1).strip()
            cleanBody = preprocessLine(body)

            # Segregate the content as a question or an answer based on post type id and dump into respective files
            if postType == '1':
                questionFile.write(cleanBody)  # To dump content into the file
                questionFile.write("\n")

            elif postType == '2':
                answerFile.write(cleanBody)  # To dump content into the file
                answerFile.write("\n")

    questionFile.close()    # To close question.txt file
    answerFile.close()      # To close answer.txt file
    input_handle.close()    # To close data.xml file


if __name__ == "__main__":
    f_data = "data.xml"
    f_question = "question.txt"
    f_answer = "answer.txt"
    splitFile(f_data, f_question, f_answer)
