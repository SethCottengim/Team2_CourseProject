# Clear the workspace
rm(list = ls()) # Clear environment
gc()            # Clear memory
cat("\f")       # Clear console
#load data
sales_cities <- read.csv("project.sales.cities.csv")
sales_counties <- read.csv("project.sales.counties.csv")
sales_zipcodes <- read.csv("project.sales.zipcodes.csv")
acs_cities <- read.csv("project.acs.cities.csv")
acs_counties <- read.csv("project.acs.counties.csv")
acs_zipcodes <- read.csv("project.acs.zipcodes.csv")

# Rename colums for consistency
colnames(acs_cities) <- c("city", "High School", "Bachelor", "Unemployment", "Income", "Population", "White Population", "Black Population", "Indian Population", "Asain Population", "Hawaiian Population", "Other Population", "Multi Population")
colnames(acs_counties) <- c("county", "High School", "Bachelor", "Unemployment", "Income", "Population", "White Population", "Black Population", "Indian Population", "Asain Population", "Hawaiian Population", "Other Population", "Multi Population")
colnames(acs_zipcodes) <- c("zipcode", "High School", "Bachelor", "Unemployment", "Income", "Population", "White Population", "Black Population", "Indian Population", "Asain Population", "Hawaiian Population", "Other Population", "Multi Population")
colnames(sales_cities) <- c("city", "Category", "Sales_Dollars", "Sales Volume")
colnames(sales_counties) <- c("county", "Category", "Sales_Dollars", "Sales_Volume")
colnames(sales_zipcodes) <- c("zipcode", "Category", "Sales_Dollars", "Sales_Volume")

#Merge datasets by geography
city_data <- merge(sales_cities, acs_cities, by = "city")
county_data <- merge(sales_counties, acs_counties, by = "county")
zipcode_data <- merge(sales_zipcodes,acs_zipcodes, by= "zipcode")
summary(city_data)
summary(county_data)
summary(zipcode_data)
#change to numeric
city_data$Sales_Dollars <- as.numeric(city_data$Sales_Dollars)
city_data$Population <- as.numeric(city_data$Population)
county_data$Sales_Dollars <- as.numeric(county_data$Sales_Dollars)
county_data$Population <- as.numeric(county_data$Population)
zipcode_data$Sales_Dollars <- as.numeric(zipcode_data$Sales_Dollars)
zipcode_data$Population <- as.numeric(zipcode_data$Population)

# Load zip code to city mapping dataset
zip_city_county <- read.csv("zip_codes.csv")
zip_city_county
zipcode_data

# Merge cities and counties to zip codes
mergedzip <- merge(zipcode_data, zip_city_county, by = "zipcode")
mergedcity <-merge(city_data, zip_city_county, by= "city")
mergedcounty <- merge (county_data, zip_city_county, by="county")
merged<-mergedcounty
merged
iowa_data <- subset(merged, state == "Iowa")
iowa_data
colnames(iowa_data)

#Are there pairwise patterns in total/per capita sales across geographies?
#correlation coefficients betw/ sales and population 
cor(city_data$Sales_Dollars, city_data$Population)
cor(county_data$Sales_Dollars, county_data$Population)
cor(zipcode_data$Sales_Dollars, zipcode_data$Population)
#Interpretation: The correlation coefficient for city sales in dollars and population is 0.667, indicating a moderately strong positive linear correlation. This means that as the population of a city increases, the sales in dollars tend to increase as well. 
# The correlation coefficient for county sales in dollars and population is 0.653, which also indicates a moderately strong positive linear correlation. Therefore as the population of a county increases, the sales in dollars are likely to increase as well.
#The correlation coefficient for zipcode sales in dollars and population is 0.501, which still indicates a somewhat positive linear correlation. As the population of a zipcode area increases, the sales in dollars will tend to increase, but the strength of the relationship is not as strong as for the city or county level.
#Since correlation does not necessarily imply causation, the coefficients do not represent a causal relationship between population and sales. Other factors would have to be considered (state of the economy, market demand).

# Calculate pairwise correlation coefficients for per capita sales
city_pc_corr <- cor(city_data$Sales_Dollars / city_data$Population, city_data$Population)
city_pc_corr
county_pc_corr <- cor(county_data$Sales_Dollars / county_data$Population, county_data$Population)
county_pc_corr
zipcode_pc_corr <- cor(zipcode_data$Sales_Dollars / zipcode_data$Population, zipcode_data$Population)
zipcode_pc_corr

#The correlation coefficient for cities is 0.071, which is close to zero. This suggests that there is little to no correlation between sales per capita and population in cities in Iowa.
#The correlation coefficient for counties is 0.181, which is a weak positive correlation. This suggests that there is a small positive relationship between sales per capita and population in counties in Iowa, meaning that as population increases, sales per capita tend to increase slightly as well.
#The correlation coefficient for zipcodes is 0.117, which is also a weak positive correlation. This suggests that there is a small positive relationship between sales per capita and population in zipcodes in Iowa, meaning that as population increases, sales per capita tend to increase slightly as well.

# Create a scatterplot of sales per capita and population for each geography
library(ggplot2)
ggplot(city_data, aes(x = Population, y = Sales_Dollars / Population)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Sales per Capita vs Population in Iowa Cities")

ggplot(county_data, aes(x = Population, y = Sales_Dollars / Population)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Sales per Capita vs Population in Iowa Counties")

ggplot(zipcode_data, aes(x = Population, y = Sales_Dollars / Population)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Sales per Capita vs Population in Iowa Zipcodes")

#Visualizations
library(tidyverse)
city_data %>%
  ggplot(aes(x = Population, y = Sales_Dollars / Population)) +
  geom_point() +
  labs(x = "Population", y = "Sales per Capita", title = "City Sales per Capita vs Population")

county_data %>%
  ggplot(aes(x = Population, y = Sales_Dollars / Population)) +
  geom_point() +
  labs(x = "Population", y = "Sales per Capita", title = "County Sales per Capita vs Population")

zipcode_data %>%
  ggplot(aes(x = Population, y = Sales_Dollars / Population)) +
  geom_point() +
  labs(x = "Population", y = "Sales per Capita", title = "Zipcode Sales per Capita vs Population")





library(ggplot2)
  
  #  total sales and population
  sales_by_county <- aggregate(iowa_data$Sales_Dollars, by = list(county = iowa_data$county), FUN = sum)
  sales_by_county
  population_by_county <- aggregate(iowa_data$Population, by = list(county = iowa_data$county), FUN = sum)
  population_by_county
  
  # Merge data by county
  merged_data <- merge(sales_by_county, population_by_county, by = "county")
  merged_data
  
  # sales per capita
 sales_per_capita <- merged_data$x.x / merged_data$x.y
 sales_per_capita
  
 # scatter plot of total sales vs. population
 ggplot(iowa_data, aes(x = iowa_data$Population, y = iowa_data$Sales_Dollars)) +
   geom_point() +
   labs(x = "Population", y = "Total Sales Dollars") +
   ggtitle("Total Sales vs. Population by County")
 
 ggplot(iowa_data, aes(x = county, y = Sales_Dollars)) +
   geom_col() +
   labs(x = "County", y = "Total Sales Dollars") +
   ggtitle("Total Sales by County") +
   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
 
  
  
 # Group data by zipcode and city and calculate mean sales
 sales_by_zipcode <- aggregate(iowa_data$Sales_Dollars, by = list(zipcode = iowa_data$zipcode, city = iowa_data$city), FUN = mean)
 sales_by_city <- aggregate(iowa_data$Sales_Dollars, by = list(city = iowa_data$city), FUN = mean)
 
 sales_by_city <- as.numeric(sales_by_city)
 # Merge data by city
 merged_sales <- merge(sales_by_zipcode, sales_by_city, by = "city", suffixes = c("_zipcode", "_city"))
 
 # Calculate correlation between average sales per zipcode and average sales per city for each category
 categories <- unique(iowa_data$Category)
 categories
 correlations <- data.frame(category = character(), correlation = numeric(), stringsAsFactors = FALSE)
 correlations
 
 ##############Not finalized yet:
 # Group data by zipcode and city and calculate mean sales
 sales_by_zipcode <- aggregate(iowa_data$Sales_Dollars, 
                               by = list(zipcode = iowa_data$zipcode, city = iowa_data$city), 
                               FUN = mean)
 sales_by_city <- aggregate(iowa_data$Sales_Dollars, 
                            by = list(city = iowa_data$city), 
                            FUN = mean)
 
 library(dplyr)
 iowa_data %>%
   group_by(Category) %>%
   summarize(correlation = cor(subset(sales_by_zipcode, select = x), 
                               subset(sales_by_city, select = x), 
                               use = "complete.obs", method = "pearson"))
 
 
 library(ggplot2)
 
 ggplot(iowa_data, aes(x = Category, y = sales_by_zipcode)) +
   geom_bar(aes(fill = "Average Sale per Zipcode"), position = "dodge", stat = "identity") +
   geom_bar(aes(y = Average_Sale_Per_City, fill = "Average Sale per City"), position = "dodge", stat = "identity") +
   labs(x = "Liquor Category", y = "Average Sales") +
   ggtitle("Average Sales per Zipcode and City by Liquor Category") +
   scale_fill_manual(values = c("red", "blue"), name = "") +
   theme_classic()
 
 

  
# calculate average sales by zipcode
zipcode_avg_sales <- aggregate(Sales_Dollars ~ zipcode, data = zipcode_data, mean)
colnames(zipcode_avg_sales)[2] <- "Sales_Dollars"
zipcode_avg_sales

# calculate average sales by city
city_avg_sales <- aggregate(Sales_Dollars ~ city, data = city_data, mean)
colnames(city_avg_sales)[2] <- "Sales_Dollars"
city_avg_sales

# calculate average sales by county
county_avg_sales <- aggregate(Sales_Dollars ~ county, data = county_data, mean)
colnames(county_avg_sales)[2] <- "Sales_Dollars"
county_avg_sales

# Load required packages
library(ggplot2)


# Create scatterplots of sales in dollars versus population for each dataset
ggplot(city_data, aes(x = Population, y = Sales_Dollars)) + 
  geom_point() + 
  ggtitle("City Data: Sales in Dollars vs Population")

ggplot(county_data, aes(x = Population, y = Sales_Dollars)) + 
  geom_point() + 
  ggtitle("County Data: Sales in Dollars vs Population")

ggplot(zipcode_data, aes(x = Population, y = Sales_Dollars)) + 
  geom_point() + 
  ggtitle("Zipcode Data: Sales in Dollars vs Population")

# Create bar plots of total sales in dollars for each dataset
ggplot(city_data, aes(x = city, y = Sales_Dollars)) + 
  geom_bar(stat = "identity") + 
  ggtitle("City Data: Total Sales in Dollars by City") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

ggplot(county_data, aes(x = county, y = Sales_Dollars)) + 
  geom_bar(stat = "identity") + 
  ggtitle("County Data: Total Sales in Dollars by County") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

ggplot(zipcode_data, aes(x = zipcode, y = Sales_Dollars)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Zipcode Data: Total Sales in Dollars by Zipcode") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))




# merge city_avg_sales and zipcode_avg_sales
merged_data <- merge(city_avg_sales, zipcode_avg_sales, by = "city", all = TRUE)
colnames(merged_data) <- c("City", "City_Avg_Sales", "Zipcode_Avg_Sales")
merged_data
correlation <- cor(merged_data$Zipcode_Avg_Sales, merged_data$City_Avg_Sales)
correlation

# calculate correlation
correlation <- cor(city_avg_sales.x, zipcode_avg_sales.y)

# print correlation
cat("Correlation between average sales per zipcode and average sales per city:", correlation)

# calculate correlation between average sales per zipcode and average sales per city
cor(sales_by_city_and_zip$Sales_Dollars_zip, sales_by_city_and_zip$Sales_Dollars_city)
var(sales_by_city_and_zip$Sales_Dollars_zip)
var(sales_by_city_and_zip$Sales_Dollars_city)
#The result is NA because there is no variation in the sales data for either the zipcodes or the cities. In other words, all the sales data for a particular zipcode or city is the same, so there is no variability to compute a correlation
#################

plot(sales_by_city_and_zip$Sales_Dollars_city, sales_by_city_and_zip$Sales_Dollars_zip,
     xlab = "Average Sales by City",
     ylab = "Average Sales by Zipcode",
     main = "Relationship Between Average Sales by Zipcode"
abline(model, col = "red") 



# Fit a linear regression model
model <- lm(Sales_Dollars ~ City_Sales_Dollars, data = zipcode_data)
summary(model)


# Histogram of total sales by category
library(ggplot2)
ggplot(sales_cities, aes(x=Category, y=Sales_Dollars)) + 
  geom_bar(stat="identity")

# Scatter plot of sales volume versus population
ggplot(city_data, aes(x = Population, y = Sales_Dollars)) +
  geom_point() +
  labs(x = "Population", y = "Sales Volume")


# Calculate average sales per zip code
avg_zip_sales <- aggregate(zipcode_data$Sales_Dollars, by=list(zipcode_data$zipcode), FUN=mean)
colnames(avg_zip_sales) <- c("zipcode", "avg_zip_sales")

# Calculate average sales per city
avg_city_sales <- aggregate(city_data$Sales_Dollars, by=list(city_data$city), FUN=mean)
colnames(avg_city_sales) <- c("city", "avg_city_sales")

# Merge average sales per zip code and city
zip_city_sales <- merge(avg_zip_sales, zipcode_data, by="zipcode")
zip_city_sales <- merge(zip_city_sales, city_data, by="city")

# Calculate correlation coefficient between average sales per zip code and city
cor(zip_city_sales$avg_zip_sales, zip_city_sales$Sales_Dollars)

# Calculate correlation coefficient between sales and population for each category
cor(city_data$Sales_Dollars[city_data$Category == "Whiskey"], city_data$Population[city_data$Category == "Whiskey"])
cor(city_data$Sales_Dollars[city_data$Category == "Vodka"], city_data$Population[city_data$Category == "Vodka"])
cor(city_data$Sales_Dollars[city_data$Category == "Rum"], city_data$Population[city_data$Category == "Rum"])
cor(city_data$Sales_Dollars[city_data$Category == "Gin"], city_data$Population[city_data$Category == "Gin"])
cor(city_data$Sales_Dollars[city_data$Category == "Tequila"], city_data$Population[city_data$Category == "Tequila"])
cor(city_data$Sales_Dollars[city_data$Category == "Brandy"], city_data$Population[city_data$Category == "Brandy"])

merged_data <- merge(sales_data, acs_data, by=c("City", "County", "Zip Code"), all.x=TRUE)

# Total sales by geography
total_sales <- aggregate(Sales ~ City + County + Zip.Code, data=merged_data, sum)

# Per capita sales by geography
merged_data$PerCapitaSales <- merged_data$Sales / merged_data$Population

per_capita_sales_by_geo <- aggregate(PerCapitaSales ~ City + County + Zip.Code, data=merged_data, mean)

# Pairwise correlation between total sales by geography and per capita sales by geography
correlation <- cor(total_sales_by_geo$Sales, per_capita_sales_by_geo$PerCapitaSales)

if (correlation > 0.5) {
  print("There is a strong positive correlation between total sales by geography and per capita sales by geography.")
} else if (correlation < -0.5) {
  print("There is a strong negative correlation between total sales by geography and per capita sales by geography.")
} else {
  print("There is no significant correlation between total sales by geography and per capita sales by geography.")
}


# Pairwise correlation between average sales per zip code and average sales by city
correlation <- cor(avg_sales_per_zip$Sales, avg_sales_by_city$Sales)

if (correlation > 0.5) {
  print("There is a strong positive correlation between average sales per")


# Fit a linear regression model to predict average sales per zip code from average sales in the corresponding city
model <- lm(Sales_Dollars_zip ~ Sales_Dollars_city, data = sales_by_city_and_zip)
summary(model)
lm(zipcode_data$Sales_Dollars ~ city_data$Sales_Dollars)
