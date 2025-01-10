--------------------------
--Payment Method Analysis
--------------------------

---least preferred payment method for each branch

WITH
	T1 AS (
		SELECT
			BRANCH,
			PAYMENT_METHOD,
			COUNT(*) AS TOTAL_TRANSACTIONS,
			RANK() OVER (
				PARTITION BY
					BRANCH
				ORDER BY
					COUNT(*) ASC
			)
		FROM
			WALMART
		GROUP BY
			1,
			2
		ORDER BY
			1,
			3
	)
SELECT
	*
FROM
	T1
WHERE
	RANK = 1
	
---most preferred payment method for each branch
WITH
	PRFERED_PAYMENT_METHOD AS (
		SELECT
			BRANCH,
			PAYMENT_METHOD,
			COUNT(*) AS NO_OF_TRANSACTIONS,
			RANK() OVER (
				PARTITION BY
					BRANCH
				ORDER BY
					COUNT(*) DESC
			)
		FROM
			WALMART
		GROUP BY
			1,
			2
		ORDER BY
			1,
			3 DESC
	)
SELECT
	*
FROM
	PRFERED_PAYMENT_METHOD
WHERE
	RANK = 1

--relationship between payment methods and customer ratings
SELECT 
    payment_method, 
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY payment_method;

--different payment method and number of transactions, number of qty sold

select payment_method,sum(quantity) as total_quantity,count(*) as total_transaction from walmart group by 1

--------------------------
--Revenue Analysis
--------------------------

--top 5 cities generating the highest revenue.
SELECT 
    city, 
    SUM(unit_price * quantity) AS total_revenue
FROM walmart
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 5;

--Calculate the revenue growth percentage for each branch over the last two years.
WITH revenue_by_year AS (
    SELECT 
        branch, 
        EXTRACT(YEAR FROM date) AS year, 
        SUM(unit_price * quantity) AS total_revenue
    FROM walmart
    GROUP BY branch, EXTRACT(YEAR FROM date)
),
revenue_growth AS (
    SELECT 
        current.branch, 
        current.total_revenue AS current_year_revenue, 
        previous.total_revenue AS previous_year_revenue,
        ROUND(((current.total_revenue - previous.total_revenue) * 100.0 / previous.total_revenue)::numeric, 2) AS revenue_growth_percentage
    FROM revenue_by_year AS current
    JOIN revenue_by_year AS previous
    ON current.branch = previous.branch AND current.year = previous.year + 1
)
SELECT 
    branch, 
    previous_year_revenue, 
    current_year_revenue, 
    revenue_growth_percentage
FROM revenue_growth
ORDER BY revenue_growth_percentage DESC;


--------------------------
--Category Insights
--------------------------

--most profitable category for each branch
select branch,category,total_revenue from(select branch,category,sum(total) as total_revenue,rank() over(partition by branch order by sum(total) desc )from walmart group by 1,2 order by 1,3 desc)
where rank=1

-- top 5 category with the highest average unit price.

select category,avg(unit_price) as avg_price from walmart group by 1 order by 2 desc limit 5

--Identify the highest-rated category in each branch, displaying the branch, category

select * from (select branch,category,avg(rating),rank() over(partition by branch order by avg(rating) desc ) as rank from walmart group by 1,2 ) 
where rank=1	

-- the average, minimum, and maximum rating of category for each city. 

select city,category,avg(rating) as average_rating,min(rating) as minimum_rating ,max(rating) as maximum_rating from walmart group by 1,2	

--------------------------
--Time-based Trends
--------------------------

--- peak sales hours for each branch
select * from (select branch, SUM(total),case when extract(hour from time)<12 Then 'Morning'
 when extract(hour from time) BETWEEN 12 AND 17 Then 'AFTERNOON' ELSE 'EVENING' END day_time ,rank() over(partition by branch order by sum(total)desc)
from walmart  GROUP BY 1,3 order by 1,3) where rank=1

-- seasonal trends (quarterly revenue) for each category.
SELECT 
    category,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(QUARTER FROM date) AS quarter,
    SUM(total) AS total_revenue
FROM walmart
GROUP BY category, year, quarter
ORDER BY category, year, quarter;

--the busiest day for each branch based on the number of transactions

SELECT * FROM
	(select branch,TO_CHAR(date,'Day')  as day_name,count(*) as no_of_transactions ,
rank() over(partition  by branch order by  count(*) desc)	
from walmart group by 1,2 order by 1,3 desc) where rank=1


--------------------------
--Profitability Insights
--------------------------

--Rank branches by profitability (total profit/revenue ratio)
SELECT 
    branch,
    SUM(unit_price * quantity * profit_margin) AS total_profit,
    SUM(unit_price * quantity) AS total_revenue,
    ROUND((SUM(unit_price * quantity * profit_margin) / SUM(unit_price * quantity))::numeric, 2) AS profit_revenue_ratio,
    RANK() OVER (ORDER BY ROUND((SUM(unit_price * quantity * profit_margin) / SUM(unit_price * quantity))::numeric, 2) DESC) AS rank
FROM walmart
GROUP BY branch
ORDER BY rank;

-- trends in profit margins by category.
SELECT 
    category,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(QUARTER FROM date) AS quarter,
    AVG(profit_margin) AS avg_profit_margin
FROM walmart
GROUP BY category, year, quarter
ORDER BY category, year, quarter;

--------------------------
--Low Rating Analysis
--------------------------

 --branches with the highest percentage of low-rated transactions
WITH rating_analysis AS (
    SELECT 
        branch,
        COUNT(*) AS total_transactions,
        COUNT(CASE WHEN rating < 5 THEN 1 END) AS low_rated_transactions
    FROM walmart
    GROUP BY branch
),
percentage_analysis AS (
    SELECT 
        branch,
        total_transactions,
        low_rated_transactions,
        ROUND((low_rated_transactions::NUMERIC / total_transactions) * 100, 2) AS low_rating_percentage
    FROM rating_analysis
)
SELECT 
    branch,
    low_rated_transactions,
    total_transactions,
    low_rating_percentage
FROM percentage_analysis
ORDER BY low_rating_percentage DESC;











































































