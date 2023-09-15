# Winery_Database

## Background:

### Introduction:

Welcome to Sonoma Quality Libations (SQL), a database I created, which started as my final project for a Database Administration class at Syracuse University. The goal of this project was to design a simple yet effective database system for managing winery operations and data. In this repository, you'll find the code, documentation, and sample data for this project, along with instructions on how to set up and use the SQL database. 

### Stakeholders:

The primary stakeholders (entities that will benefit from the use of the database) are the wineries owners, employees, and investors. Through this database, they can better track sales and see what factors (grape varietal, vintage, etc.) are affecting sales and adjust accordingly.

Other stakeholders include:
The vineyards (who supply the grapes and may or may not be owned by the winery). 
The cooperages who supplies the barrels. 
The customers who can purchase wines directly through the online store. They are also asked to rate the wines on a scale of 1-5. 
Other clients: These include stores and restaurants as well as the distributors who ship the wines to them. 

### Business Rules:

These are the rules that will dictate how the database is designed.

1. The vineyards harvest the grapes and send them to the winery. 
2. The winery receives barrels from the cooperage and ages the wine in them. 
3. The winery bottles and packages the wine. Each varietal and vintage is bottled and packaged separately. 
4. The winery sends wine to their clients (customers and businesses).
5. The businesses keep track of sales.
6. The businesses send sales data back to the winery.
7. A client (customer of business) places an order.
8. The winery receives an order form from the client.
9. The order is invoiced by the winery.
10. The invoice is recorded by the winery.
11. The order (with the copy of invoice) is shipped to the client.

### Data Questions: 

1. Are poor sales due to the varietal, vintage or oak type?

2. What varietal sells the best?

3. Do the rating and sales of a wine correlate?

4. What can be changed to raise a wines ratings/sales?

5. Which wines sell the best on the online store versus at stores/restaurant?

## Conceptual and Logical Models

### Conceptual Model

![image](https://github.com/ZChipman/Winery_Database/assets/87530934/3c2badc7-7f43-4223-9f11-7f204359f36d)

### Logical Model

![image](https://github.com/ZChipman/Winery_Database/assets/87530934/64987b7f-e7e3-45b8-a925-1ea5bbc68954)
 
## Files:

Winery_Database_Report.pdf: The final report for the IST659 final project.

Winery_Database_Code.sql: The SQL file for the final project (though the code is also written as an appendix to the final report). Microsoft SQL server is required to run this script. 

## Development:

The final database consisted of the following tables:

Vineyard - Contains infomation on the different vineyards the winery harvets grapes from.

Varietal - Contains the names of each varietal (Chardonnay, Cabernet, etc.)

Vintage - 

## Results:

## References:
