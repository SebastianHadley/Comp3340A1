import sys
from typing import Type

import numpy
import numpy as np


def main():
    data = getpresidency()
    jaccard_matrix  = get_base_matrix(data)
    hamming_matrix = jaccard_matrix
    print(len(hamming_matrix))
    print(len(jaccard_matrix))
    data = get_attributes(data)
    i = 1
    a = 1
    print(jaccard_matrix)
    while a < len(jaccard_matrix):
        while i < len(jaccard_matrix):
            # jaccard_matrix[a][i] = jaccard_binary(data[a-1], data[i-1])
            hamming_matrix[a][i] = hamming_distance(data[a-1], data[i-1])
            i += 1
        a += 1
        i = 0
    print(hamming_matrix)


def get_base_matrix(data):
    matrixsize = len(data)+1
    base_matrix = np.zeros((matrixsize, matrixsize))
    i = 1
    while i < matrixsize:
        year = data[i - 1]
        year = year[0]
        base_matrix[i][0] = int(year)
        base_matrix[0][i] = int(year)
        i+= 1
    return base_matrix
def get_attributes(data):
    i = 0
    size = len(data[0])-2
    attributes = [size]
    while i < len(data):
        data[i].pop(0)
        data[i].pop()
        i+=1
    return data
def getpresidency():
    import csv
    file = open('uspresidency.csv')
    csvreader = csv.reader(file)
    header = []
    header = next(csvreader)
    rows = []
    for row in csvreader:
        rows.append(row)
    rows
    file.close
    return rows
def jaccard_binary(x,y):
    # A function for finding the similarity between two binary values
    intersection = np.logical_and(x, y)
    union = np.logical_or(x, y)
    similarity = intersection.sum() / float(union.sum())
    return similarity
#


def hamming_distance(A,B):
    # A function for finding hamming distance.
    x = 0
    i= 0
    while(i < len(A)):
        if(A[i] != B[i]):
            x+=1
        i+=1
    return x
main()

# def jaccard_set(list1, list2):
#     """Define Jaccard Similarity function for two sets"""
#     intersection = len(list(set(list1).intersection(list2)))
#     union = (len(list1) + len(list2)) - intersection
#     return float(intersection) / union
# def jaccard_distance(A, B):
#     #Find symmetric difference of two sets
#     nominator = set(A).symmetric_difference(set(B))
#     #Find union of two sets
#     denominator = set(A).union(set(B))
#     #Take the ratio of sizes
#     distance = len(nominator)/len(denominator)
#     print("hi")
#     return distance
# pairs = np.matrix(tuple(data), tuple(data))
# print(data)