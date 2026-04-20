import pandas as pd
import numpy as np
import plotly.express as px
blood_pressure = pd.read_csv("bloodpressure.csv")
tdf = px.data.gapminder()
fig = px.scatter(tdf, x="gdpPercap", y="lifeExp", animation_frame="year", animation_group="country",
           size="pop", color="continent", hover_name="country", facet_col="continent",
           log_x=True, size_max=45, range_x=[100,100000], range_y=[25,90])
fig.show()
path = ""
bpdf= pd.read_csv(path+"bloodpressure.csv")
print(bpdf.columns)
bpdf.head()
print(bpdf.head())
fig = px.choropleth(bpdf, locations="ISO",
                   color="Mean diastolic blood pressure (mmHg)",
                   hover_name = "Country/Region/World",
                   color_continuous_scale= px.colors.sequential.Plasma)
fig.show()
hdf= bpdf.groupby(
    ["Country/Region/World", "ISO"],
                  as_index=False
)[[
    "Mean systolic blood pressure (mmHg)",
   "Mean diastolic blood pressure (mmHg)"
    ]].mean()
hdf= hdf[hdf["Mean systolic blood pressure (mmHg)"]>110]  

fig = px.choropleth(hdf, locations= "ISO",
                    color="Mean systolic blood pressure (mmHg)",
                    hover_name="Country/Region/World",
                    color_continuous_scale=px.colors.sequential.Plasma)
fig.show()
