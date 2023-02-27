# Team 2 - Course Porject!


## Scope 🥇
  - Practice data management, visualization, and analysis techniques.
  - Report an analytical story in an R markdown file *posted to this GitHub repo*.
  - Record and present a five minute presentation on findings.

## Data 🧮
All data files are located inside the **project.data.zip** archive
### Files
| File                   | Description                         |
| ---------------------- | ----------------------------------- |
| project.sales.zipcodes | Avg annual liqour sales per zipcode |
| project.sales.cities   | Avg annual liqour sales per city    |
| project.sales.counties | Avg annual liqour sales per county  |
| project.acs.counties   | ACS data on Iowa counties           |
| project.acs.cities     | ACS data on Iowa counties           |
| project.acs.zipcodes   | ACS data on Iowa counties           |

### Variables [cities]
| File | Variable | Description |
|------|----------|-------------|
| project.sales.zipcodes | <samp>zipcode</samp><br/> <samp>category</samp><br/> <samp>sale dollars</samp><br/> <samp>sale volume</samp>| Zipcode<br/> Liquor category<br/> Avg annual cost of liquor sold in dollars<br/> Avg annual vol of liquor sold in liters |
| project.sales.cities | <samp>city</samp><br/> <samp>category</samp><br/> <samp>sale dollars</samp><br/> <samp>sale volume</samp>| City name<br/> Liquor category<br/> Avg annual cost of liquor sold in dollars<br/> Avg annual vol of liquor sold in liters |
| project.sales.counties | <samp>county</samp><br/> <samp>category</samp><br/> <samp>sale dollars</samp><br/> <samp>sale volume</samp>| County name<br/> Liquor category<br/> Avg annual cost of liquor sold in dollars<br/> Avg annual vol of liquor sold in liters |

### Variables [acs]
| Variable | Description |
|----------|-------------|
|<samp>high.school</samp>| % of population, high school grad or higher |
|<samp>bachelor</samp>| % of population, bachelor's degree or higher |
|<samp>unemployment</samp>| Unemployment rate, age 16+ |
|<samp>income</samp>| Median earnings $ |
|<samp>population</samp>| Total population |
|<samp>pop.white </samp>| Total population - white |
|<samp>pop.black</samp>| Total population - black |
|<samp>pop.indian</samp>| Total population - American Indian/Alaska Native |
|<samp>pop.asian</samp>| Total population - Asian |
|<samp>pop.hawai</samp>| Total population - Native Hawaiian/Pacific Islander |
|<samp>pop.other</samp>| Total population - other single race |
|<samp>pop.multi</samp>| Total population - two or more races |

## Requirments ✍️
  1. Create GitHub repo ✔️
  2. **Analyze and visualize ACS data** using Tableau and/or R
  3. **Analyze and visualize aggregated sales data** using Tableau and/or R.
  4. **Merge** aggregated **liquor sales data with ACS data per each geography** (zipcodes,
cities, counties). This will result in 3 data sets. Pro Tips: If using Tableau, use 3 workbooks. When merging ACS and annual sales data, make sure to **use full outer merge**, as it is possible that not all ACS geographies have recorded liquor sales and/or not all sales geographies have corresponding matches among ACS geographies
  5. **Visualize and identify patterns in liquor sales across geographies and ACS metrics** using R and/or Tableau.
  6. **Submit draft of progress** at Checkpoint 1 and Checkpoint 2. ✔️
  7. Summarize your findings in a short **video presentation**.
  8. Publish a detailed, well formatted **R markdown report of your analytical story** to your GitHub repository. Report requirements are outlined below.


## Team 2 Mission 💪
Are there pairwise patterns in total/per capita sales across geographies? Are there correlations between avg. sales per zipcode and avg. sales in corresponding city? Does the pattern differ across liquor categories?

## Report Rubric 🙃
  1. **Intro (5pts):** Provide context regarding your decision maker, organization, and overall decision climate. State your research question. Explain how policy decisions will affect your organization and the broader community.
  2. **Data Summary (5pts):** Provide a short description of the nature of the provided data set and explain how these characteristics affect your analysis methodology. Summarize the data set with basic descriptive statistics as applicable. 
  3. **Data Analytics (50pts):** Provide data analytics that add clarity to the research question. Thoroughly discuss insight obtained from your visualizations and analysis of aggregated, ACS and merged datasets, including trends or specific data points (Tasks 2-5). Suggest an excursion, and provide supporting analysis. Plots should be well formatted according to best practices learned in class. Discuss the advantages and challenges of performing analysis in your chosen software tool.
  4. **Conclusion (10pts):** Summarize the analytical methodology and provide closure to your analytical story. Succinctly answer the research questions. Highlight the limitations of your findings and recommend future work. Do not make policy recommendations here.
  5. **Policy recommendation (10pts):** Introduce a specific policy decision that your decision maker is facing. Provide a data driven recommendation for their decision. Explain probable first and second order effects of the recommendation. Explain the benefits and risks of the recommendation.
