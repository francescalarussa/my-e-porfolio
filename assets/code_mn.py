import pandas as pd
mn_data = pd.read_spss("mn.sav")
print(mn_data.head())
print(mn_data.info())
mn_data_reduced = mn_data.iloc[:,:10]
descriptive_headers = pd.read_csv("mn_headers.csv", sep=";")
print(descriptive_headers.columns)
mn_data_reduced.columns = descriptive_headers["description"][:10].tolist()
mn_data_reduced.to_csv("mn_reduced.csv", index=False)
print(mn_data_reduced.head())
print(mn_data_reduced.info())
from csv import DictReader
mn_data_rdr = DictReader(open("mn_reduced.csv", "r", encoding="utf-8"))
mn_data = [row for row in mn_data_rdr]
print(mn_data[0])
print(len(mn_data))
unique_rows=[]
for row in mn_data:
    if row not in unique_rows:
        unique_rows.append(row)
print(len(unique_rows))
def combine_data_dict(data_rows):
    data_dict = {}
    for row in data_rows:
        key = "%s-%s" % (row.get("Cluster number"),
                         row.get("Household number"))
        if key in data_dict:
            data_dict[key].append(row)
        else:
                data_dict[key] =[row]

    return data_dict
mn_households = combine_data_dict(mn_data)
print(len(mn_households))
mn_per_hh = [len(members) for members in mn_households.values()]
num_hh = len(mn_households)
avarage_men = sum(mn_per_hh)/ num_hh
print("num_households:", num_hh)
print("Avarage men per household:", round(avarage_men,2))
