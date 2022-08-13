from typing import Type

import numpy as np


def main():
    data = []
    data = getpresidency()
    jaccardmatrix = [[]]
    i = 0
    while i < len(data):
        data[i].pop(0)
        i += 1
    i = 0
    a = 0
    while i < len(data):
      data[i] = [eval(x) for x in data[i]]
      i += 1

    print(jaccard_binary(data[0],data[1]))
    print(hamming_distance(data[0],data[1]))
    matrix = np.multiply(data, data)
    print(data)
    print(matrix)
    return
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
    """A function for finding the similarity between two binary vectors"""
    intersection = np.logical_and(x, y)
    union = np.logical_or(x, y)
    similarity = intersection.sum() / float(union.sum())
    return similarity
#


def hamming_distance(A,B):
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