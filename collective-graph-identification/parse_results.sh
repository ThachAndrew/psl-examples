#!/bin/bash
#
# Prints the F1 score of each subproblem

grep -Po --color "F1: \K[0-9]*\.[0-9]*" results/experiment::enron/fold::0*/out.txt
