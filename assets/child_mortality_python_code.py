import pandas as pd
import sqlite3
neonatal_mortality = pd.read_csv("neonatal_mortality.csv", skiprows=14, sep=";")
print(neonatal_mortality.head())
neonatal_mortality.columns = neonatal_mortality.columns.str.strip()
columns_to_keep = ["ISO.Code", "Country.Name", "SDG.Region", "SDG.Subregion","UNICEF.Region","UNICEF.Programme.Region","Uncertainty.Bounds*","1989.5","1990.5","1991.5","1993.5","1994.5","1995.5","1996.5","1997.5","1998.5","1999.5","2000.5","2001.5","2002.5","2003.5","2004.5","2005.5","2006.5","2007.5","2008.5","2009.5","2010.5","2011.5","2012.5","2013.5","2014.5","2015.5","2016.5","2017.5","2018.5","2019.5","2020.5","2021.5","2022.5","2023.5"]
clean_neonatal_mortality_data= neonatal_mortality[columns_to_keep]
clean_neonatal_mortality_data.isna().sum()
clean_neonatal_mortality_data= clean_neonatal_mortality_data.dropna(axis=1, how="all")
print(len(clean_neonatal_mortality_data.columns))
print(clean_neonatal_mortality_data.columns)
print(clean_neonatal_mortality_data.isna().mean() * 100)
clean_neonatal_mortality_data["SDG.Subregion"]= clean_neonatal_mortality_data["SDG.Subregion"].fillna("Not classified")
connection= sqlite3.connect("neonatal_mortality_data.db")
clean_neonatal_mortality_data.to_sql("child_mortality", connection , if_exists="replace", index=False)
connection.close()
connection_2=sqlite3.connect("neonatal_mortality_data.db")
query= "SELECT * FROM child_mortality LIMIT 6;"
neonatal_mortality_check = pd.read_sql(query, connection_2)
print(neonatal_mortality_check)
connection_2.close()
