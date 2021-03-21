# Importing preprocessLine method from preprocessData_30513669.py
from preprocessData import preprocessLine

# Importing required libraries
import re

""" 
Class Parser has methods:
1. __init__             # Constructor to create instances of the class. inputString (argument) is a row of data from the XML file
2. __str__              # To print the object values in readable form
3. getID                # To get row id from inputString
4. getPostType          # To get post type id from inputString
5. getDateQuarter       # To get date quarter from inputString e.g. 2016Q1 
6. getCleanedBody       # To get cleaned body i.e. without xml/HTML tags from inputString
7. getVocabularySize    # To get vocabulary size of inputString from data set
"""


class Parser:

    # Initializing object variables
    def __init__(self, inputString):
        self.inputString = inputString
        self.ID = self.getID()
        self.type = self.getPostType()
        self.dateQuarter = self.getDateQuarter()
        self.cleanBody = self.getCleanedBody()

    # To print in user friendly manner in order of row id, post type id. creation date quarter and cleaned body
    def __str__(self):
        if self.getID() != "":
            endString = "Row ID : " + self.getID() + "\n" + "Post Type ID : " + self.getPostType() + "\n" + "Creation Date Quarter : " + \
                      self.getDateQuarter() + "\n" + "Cleaned Content : " + self.getCleanedBody() + "\n\n"
        else:
            endString = ""
        return endString

    # To get the row id of the inputString
    def getID(self):
        row = re.search('row Id="(.*?)"', self.inputString)
        if row is not None:
            row = row.group(1).strip()
        else:
            row = ""
        return row

    # To get post type id of the inputString
    def getPostType(self):
        if self.getID() != "":
            postType = re.search('PostTypeId="(.*?)"', self.inputString)
            postType = postType.group(1).strip()
        else:
            postType = ""
        return postType

    # To get creation data quarter from inputString
    def getDateQuarter(self):
        if self.getID() != "":
            # Search for creation date in format yyyy-mm-dd
            creationDate = re.search('CreationDate="(.*?)T', self.inputString)
            creationDate = creationDate.group(1).strip()

            # Search for year from creation date in format yyyy
            year = re.search('(^[0-9]{4})-', creationDate)
            year = year.group(1).strip()

            # Search for month from creation date in format mm
            month = re.search('-([0-9]{2})-', creationDate)
            month = month.group(1).strip()

            # To categorize a month as part of a quarter of a year
            if month == '01' or month == '02' or month == '03':
                month = 'Q1'
            elif month == '04' or month == '05' or month == '06':
                month = 'Q2'
            elif month == '07' or month == '08' or month == '09':
                month = 'Q3'
            elif month == '10' or month == '11' or month == '12':
                month = 'Q4'
            creationDate = year + month
        else:
            creationDate = ""
        return creationDate

    # To get cleaned body from inputString
    def getCleanedBody(self):
        if self.getID() != "":
            body = re.search('Body="(.*?)" />', self.inputString)
            body = body.group(1).strip()
        else:
            body = ""

        # Passing the body as argument to the preprocessLine method from preprocessData_30513669.py
        cleanBody = preprocessLine(body)
        return cleanBody

    # To get vocabulary size of inputString
    def getVocabularySize(self):

        # Initializing a wordList (list)
        wordList = []

        if self.getID() != "":
            # To convert cleaned body into lower case
            cleanedBody = self.getCleanedBody().lower()

            # Removing all the punctuations from the cleaned body
            nonPunctuationCleanedBody = re.sub(r'[!"#\$%&\'\(\)\*\+,-\./:;<=>?@\[\\\]\^_`{|}~]', '', cleanedBody)

            # To convert string into a list by splitting the string based on space
            nonPunctuationCleanedBodyList = nonPunctuationCleanedBody.split()

            # To store unique words from nonPunctuationCleanedBodyList
            for word in nonPunctuationCleanedBodyList:
                if word not in wordList:
                    wordList.append(word)
            vocabularySize = len(wordList)
        else:
            vocabularySize = None

        return vocabularySize
