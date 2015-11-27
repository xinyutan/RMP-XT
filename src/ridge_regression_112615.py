"""
This script is to repeat what we did in MDST seminar. Just get a sense of the data. 
"""

import pandas as pd
import sklearn.linear_model
from sklearn.feature_extraction.text import ENGLISH_STOP_WORDS, CountVectorizer
import numpy as np
import re

## load the data

train = pd.read_csv('D:\\Google Drive\\KaggleProjects\\MDST Professor Ratings Anlysis\\RMP-XT\\Data\\train.csv')
test = pd.read_csv('D:\\Google Drive\\KaggleProjects\\MDST Professor Ratings Anlysis\\RMP-XT\\Data\\test.csv')

# Construct bigram representation
count_vect = CountVectorizer(min_df=120, ngram_range=(1,2))

# "Fit" the transformation on the training set and apply to test
Xtrain = count_vect.fit_transform(train.comments.fillna(''))
Xtest = count_vect.transform(test.comments.fillna(''))

print Xtrain.shape, Xtest.shape

Ytrain = np.ravel(train.quality)
ybar = np.mean(Ytrain)

cl = sklearn.linear_model.Ridge()
cl.fit(Xtrain,np.array(Ytrain))
Yhat = cl.predict(Xtest)

df = pd.DataFrame(data={'words':count_vect.get_feature_names(),
                        'coef':cl.coef_.flatten()
                    })
df.sort('coef',ascending=False,inplace=True)

print("Ridge Coefficients")
print("Most positive:")
print(df[0:30])
print("Most negative")
print(df[-30:])

submit = pd.DataFrame(data={'id': test.id, 'quality': Yhat})
submit.to_csv('ridge_submit.csv', index = False)