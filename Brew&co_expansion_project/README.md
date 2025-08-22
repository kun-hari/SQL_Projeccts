# **Bean & Co Expansion SQL Project**

## *Objective*
The objective of this project is to conduct a comprehensive analysis of the sales data from Bean & co., which has been operating its online business since January 2023. Based on consumer demand and sales performance, the analysis aims to identify and recommend the top three cities in India best suited for establishing new coffee shop locations.

## *Key Questions*

1. ### Estimated Coffee Consumer Count by City
    Determine the projected number of coffee consumers in each city, based on the assumption that 25% of the local population consumes coffee.

2. ### Aggregate Revenue from Coffee Sales for Q4 2023
    Calculate the total revenue generated from coffee sales across all cities during the fourth quarter of 2023.

3. ### Product-Specific Sales Volume
    Report the number of units sold for each coffee product within the reporting period.

4. ### Average Sales Value per Customer by City
    Analyze the average sales amount per customer in each city.

5. ### City-wise Population and Coffee Consumer Estimates
    Provide a comprehensive list of cities, including population figures and corresponding estimates of coffee consumers.

6. ### Top-Selling Products by City
    Identify the three highest-selling coffee products in each city, based on unit sales.

7. ### Customer Breakdown by City
    Quantify the total number of unique customers in each city who have purchased coffee products.

8. ### Sales and Rent Comparison by City
    For each city, report both the average sale per customer and the average rent per customer.

9. ### Monthly Sales Growth Analysis
    Calculate the percentage growth or decline in coffee sales month-over-month.

10. ### Market Potential Assessment
    Identify the top three cities with the highest overall sales, and report for each: city name, total sales, total rent, total customer count, and estimated coffee consumer population.

## *Data Used*
**City Data**: Includes city ID, name, population, estimated rent, and city rank.

**Customers Data**: Contains customer ID, name, and linked city ID.

**Products Data**: Information on product ID, product name, and price.

**Sales Data**: Records individual sales with sale ID, date, product ID, customer ID, total sale amount, and rating.

## *Methodology*
- Database schema created with normalized tables representing cities, customers, products, and sales.

* Queries constructed to analyze sales data, customer behavior, and demographic insights for multiple cities.

+ Calculations performed to estimate coffee consumer counts per city assuming 25% consumption of population.

- Sales aggregated across different dimensions (total, by city, by product) to evaluate revenue and sales performance.

- Product popularity ranked per city using window functions (DENSE_RANK) over sales data.

- Metrics computed such as average sales per customer, rents per customer, and monthly growth rates to identify trends.

- Market potential assessed by combining sales, customer counts, rents, and estimated consumer population to recommend optimal store locations.

## *Observations and Results*
- Cities ranked by estimated coffee consumers, with populations scaled to millions for clarity.

- Total revenue for the last quarter of 2023 aggregated and broken down by city for detailed comparison.

- Highest selling products identified per city, highlighting customer preferences regionally.

- Customer segmentation revealed the number of unique buyers and total products purchased city-wise.

- Rent efficiency analyzed through average rent per customer alongside average sales per customer to evaluate cost-effectiveness.

- Monthly sales growth rates provided insights into sales trends, indicating periods of growth and decline per city.

- Market potential analysis highlighted Pune, Delhi, and Jaipur as top candidates for new store openings, balancing high sales volumes, customer base, and rental costs.

## *Recommendations*

Following comprehensive data analysis, the top three cities identified for new store launches are as follows:

**City 1: Pune**    
1. Achieves the highest total sales revenue across all cities (₹1,258,290).
2. Records the highest average sale amount per customer (₹22,479).
3. Benefits from a very low average rent, both in total (₹15,300) and per customer (₹294.23), enhancing overall profitability.

**City 2: Delhi**   
1. Represents a significant market opportunity with the highest estimated coffee consumer base in the country, approximately 7.7 million individuals.
2. Hosts a large customer base, with a total of 68 unique customers recorded.
3. Maintains a competitive average rent per customer of ₹330, which remains well below the ₹500 benchmark, supporting cost-effective operations.

**City 3: Jaipur**
1. Leads in the number of individual customers, totaling 69 — the highest nationwide.
2. Offers the lowest average rent per customer at ₹156, enabling cost-efficient engagement with the market.
3. Demonstrates consistent and strong average sales per customer, averaging ₹11,600.

These cities collectively represent optimal locations for geographical expansion, balancing high sales potential, favorable rental costs, and substantial customer bases.
