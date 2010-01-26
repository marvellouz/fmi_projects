import sys
from easygui import *
msg="Welcome to Simple Calculator!";
title="Simple Calculator"
choices=["Enter","About","Exit"]
choice=indexbox(msg,title,choices)

def input_numbers():    #a function to take input
    global a,b
    a=float(enterbox("First Number"))
    b=float(enterbox("Second Number"))

def manipulations():    #defines a function to perform arithmetic manipulations
    title="Simple Calculator"
    msg="Select Action"
    choices=["Addition","Subtraction","Multiplication","Division","Exit"]
    select=indexbox(msg,title,choices)
    if select==0:
        input_numbers()
        result=a+b
        msgbox("The Result is %s"%result)
    elif select==1:
        input_numbers()
        result=a-b
        msgbox("The Result is %s"%result)
    elif select==2:
        input_numbers()
        result=a*b
        msgbox("The Result is %s"%result)
    elif select==3:
        input_numbers()
        result=a/b
        msgbox("The Result is %s"%result)
    else:
        sys.exit(0)

def loop():
    manipulations()
    title="Confirmation"
    msg="Really Exit?"
    if ynbox(msg,title):
        sys.exit(0)
    else:
        pass
        manipulations()

if choice==0:
    while True:
        loop()
elif choice==1:
    msgbox("Simple Calculator\nVersion:1.0\nCreated by-atik2009\nMail Me:atik.bd08@gmail.com","About")
    sys.exit(0)

else:
    sys.exit(0)

