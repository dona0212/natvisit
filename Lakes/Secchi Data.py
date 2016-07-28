import pandas as pd

pd.set_option('display.width', 500)
pd.set_option('display.float_format', lambda x: '%.2f' % x)

months_subset = [5,6,7]


secchi = pd.read_table('/Users/thom2117/Documents/SCIENCE/LAGOS/DavesData/lagos/LAGOS_LIMNO_v1.054.1/lagos_secchi_10541.txt')
# secchi = pd.read_table('C:/Users/rrnoe/NatCap/SESYNC/LAGOS_LIMNO_v1.054.1/lagos_secchi_10541.txt')

# print secchi
subset_secchi = secchi[secchi['samplemonth'].isin(months_subset)]



grouped_subset_secchi = subset_secchi.groupby('lagoslakeid').mean()['secchi']
print grouped_subset_secchi

