#!/usr/bin/env python3
import sys

print("This script attempts to provide guidance to companies on compliance priorities.")
#The below checks if this script is runable, it requires python3. If and when Python4 comes out this will need to be updated. 
print("Checking if you can run this script....")

def check_python_version():
    if sys.version_info[0] == 3:
        print("Done! you can run it!")
    else:
        print("This script requires Python 3. You are running Python {}.".format(sys.version_info[0]))
        sys.exit(1)

if __name__ == "__main__":
    check_python_version()

'''The get_string_input function below determines whether the input is a string
and if it is not the function will request the user to reanswer the question. 
This removes spaces and commas temorarily to ensure that all characters are letters
with isalpha and then if it is a string (all alphabetical) it accepts the input.
'''
def get_string_input(prompt):
    while True:
        response = input(prompt + " ")
        if response.replace(" ", "").replace(",", "").isalpha():
            return response
        else:
            print("Please enter a valid text reponse with no symbols execept commas and no numbers.")

'''The get integer function below checks if the response is an integer through attempting to convert 
 it to an integer if it is not an integer like a letter or symbol the int will return a value error 
 which defines the error and allows this to rerequest an answer.''' 
def get_integer_input(prompt):
    while True:
        try:
            response =int(input(prompt+ " "))
            return response
        except ValueError:
            print("Please only enter an integer for this question.")

def collect_demographic_data():
#This is where the responseses will be stored
    responses = {}

    #We want to ensure users only input designated data types so we specify the question 
    # and answer type below. 
    questions ={
        "How many employees does your company have?": "integer",
        "In which industry does your company operate?": "string",
        "What types of data does your company store or process? (e.g., personal data, financial data, health records)": "string",
        "Does your company store or process personal data of individuals from the European Union?": "string",
        "Does your company have government contracts?": "string",
        "Does your company accept payment cards as payment?": "string", 
        "do you have designated point-of-sale systems?": "string",
        "In which countries does your company conduct business?": "string",
        "Does your company transfer data across international borders?": "string",
        "What services does your company provide to clients?": "string",
        "Is your company publicly traded or privately held?": "string",
        "Does your company have a designated compliance or risk management team?": "string",
        "Has your company experienced any data breaches or cybersecurity incidents in the past?": "string",
        "Does your company have an internal IT or cybersecurity team?": "string",
        "Does your company have formalized cybersecurity policies or practices?": "string",
        "Does your company work with third-party vendors or subcontractors?": "string",
        "Does your company operate any data centers or physical facilities where data is stored?": "string",
        "Does your company have a business continuity or disaster recovery plan in place?": "string",
        "Does your company process health data?": "string",
        "Does your company store personally identifiable information related to someone's health?": "string",
        "Does your company conduct business in California?": "string",
        "Does your company collect, store, or process biometric data?": "string"
    }

    '''This part of the code iterates through each question, depending on response type and 
    stores the response in the dictionary named responses.This allows us to iterate through the responses
    and ensure approrpiate responses and printing the responses.'''

    for question, response_type in questions.items():
        if response_type == "integer":
            responses[question] = get_integer_input(question)
        elif response_type == "string":
            responses[question] = get_string_input(question)
    print("Finished Collecting data.")
    return responses

#This calls the collect demographic function to run 
demographic_data = collect_demographic_data()
#this prints the responses for error handling and neatly shows the output. 
print("\nCollected Demographic Data:")
for question, answer in demographic_data.items():
    print(f"{question}: {answer}")

