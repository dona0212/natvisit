import pandas as pd

pd.set_option('display.width', 500)
pd.set_option('display.float_format', lambda x: '%.2f' % x)

months_subset = [5,6,7,8]


# secchi = pd.read_table('/Users/thom2117/Documents/SCIENCE/LAGOS/DavesData/lagos/LAGOS_LIMNO_v1.054.1/lagos_secchi_10541.txt')
secchi = pd.read_table('C:/Users/rrnoe/NatCap/SESYNC/LAGOS_LIMNO_v1.054.1/lagos_secchi_10541.txt')


pud = pd.read_csv('C:/Users/rrnoe/NatCap/SESYNC/natvisit/private_data/lakes_PUD.csv')
pud.rename(columns={'lagoslakei': 'lagoslakeid'}, inplace=True)


subset_secchi = secchi[secchi['samplemonth'].isin(months_subset)]
grouped_subset_secchi = subset_secchi.groupby('lagoslakeid').mean()


result = pd.merge(grouped_subset_secchi, pud, left_index=True, right_on='lagoslakeid', how='inner')


result.to_csv('C:/users/rrnoe/desktop/real_data.csv')
