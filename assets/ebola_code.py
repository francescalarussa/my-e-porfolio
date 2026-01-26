import pandas as pd
ebola = pd.read_csv("/Users/francescalarussa/Desktop/ebola ex/CaseNotification_schieffelin.csv")
print(ebola.head())
print(ebola.columns)
print(ebola.info())
print(ebola.describe())
print(ebola.isnull().sum())
ebola_cleaned= ebola.dropna(subset=['EbolaResult_cn', 'DOAdm_cn','Age_cn'])
symptoms =['Fever_cn', 'Vomit_cn', 'Diarrhea_cn','Cough_cn','Weakness_cn', 'Headache_cn']
for sym in symptoms:
    if sym in ebola_cleaned.columns:
        ebola_cleaned[sym]=ebola_cleaned[sym].fillna(False)

num_cols=['Temp_cn','Systolic_cn','Diastolic_cn','Hrate_cn','Rrate_cn', 'Age_cn','Weight_cn', 'Height_cn']
for col in num_cols:
    if col in ebola_cleaned.columns:
        ebola_cleaned[col]=pd.to_numeric(ebola_cleaned[col], errors='coerce')
        ebola_cleaned[col]= ebola_cleaned[col].fillna(ebola_cleaned[col].median())
    print("\nMissing Value after cleaning:")
    print(ebola_cleaned.isnull().sum())
    
