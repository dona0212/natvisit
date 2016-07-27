import pandas as pd

pd.set_option('display.width', 500)
pd.set_option('display.float_format', lambda x: '%.2f' % x)

secchiframe = pd.read_table('/Users/thom2117/Documents/SCIENCE/LAGOS/DavesData/lagos/LAGOS_LIMNO_v1.054.1/lagos_secchi_10541.txt')
print secchiframe

print secchiframe.groupby('lagoslakeid').mean()