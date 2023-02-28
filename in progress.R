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
city_data
county_data
zipcode_data
#change to numeric
city_data$Sales_Dollars <- as.numeric(city_data$Sales_Dollars)
city_data$Population <- as.numeric(city_data$Population)
county_data$Sales_Dollars <- as.numeric(county_data$Sales_Dollars)
county_data$Population <- as.numeric(county_data$Population)
zipcode_data$Sales_Dollars <- as.numeric(zipcode_data$Sales_Dollars)
zipcode_data$Population <- as.numeric(zipcode_data$Population)


#correlation coefficients betw/ sales and population 
cor(city_data$Sales_Dollars, city_data$Population)
cor(county_data$Sales_Dollars, county_data$Population)
cor(zipcode_data$Sales_Dollars, zipcode_data$Population)



# calculate average sales by zipcode
zipcode_avg_sales <- aggregate(Sales_Dollars ~ zipcode, data = zipcode_data, mean)
colnames(zipcode_avg_sales)[2] <- "Sales_Dollars"

# calculate average sales by city
city_avg_sales <- aggregate(Sales_Dollars ~ city, data = city_data, mean)

##############Not finalized yet:
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

# Average sales per zip code
avg_sales_per_zip <- aggregate(Sales ~ Zip.Code, data=merged_data, mean)

# Average sales by city
avg_sales_by_city <- aggregate(Sales ~ City, data=merged_data, mean)

# Pairwise correlation between average sales per zip code and average sales by city
correlation <- cor(avg_sales_per_zip$Sales, avg_sales_by_city$Sales)

if (correlation > 0.5) {
  print("There is a strong positive correlation between average sales per")


# Fit a linear regression model to predict average sales per zip code from average sales in the corresponding city
model <- lm(Sales_Dollars_zip ~ Sales_Dollars_city, data = sales_by_city_and_zip)

summary(model)
lm(zipcode_data$Sales_Dollars ~ city_data$Sales_Dollars)
