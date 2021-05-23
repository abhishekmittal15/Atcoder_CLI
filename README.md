# Atcoder CLI

## Purpose

This is a repository meant for automating the tedious process of copying testcases and submitting solutions manually during an Atcoder Contest. The scripts are written in Powershell, so I highly doubt they would be of any use to anyone. Nevertheless leave a star, even if you are a Linux user.

## Functionality 

There are 3 main scripts. 

### `atcprep.ps1`

This script takes input the contest name and then creates a folder of the same name. Then it creates a folder for each task where you will find all the sample inputs and outputs for that particular task. It also creates a sol.cpp file where you can write your solution

### `atctest.ps1`

This script tests your `sol.cpp` file against the sample inputs and compares your outputs to the expected outputs and displays the result. For this make sure you are in the directory whose task you want to verify your solution for.

### `atcsub.ps1`

This script automates your submission process. Make sure you manually type in your username and password in the script. Also be in the directory whose task you want to submit your solution for.

## Upcoming Features 

I will soon add a script that gives you all the stats for the competition like:
1. Time remaining 
2. Table of tasks and result of solution along with Time taken and memory consumed, score achieved 
3. Ranking 