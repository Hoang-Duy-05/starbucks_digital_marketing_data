--1. Demographic analysis--
--Age affects average order value--
SELECT 
	distinct([user_id]),
	[age],
	avg([order_value]) AS avg_Value
FROM [dbo].[starbucks_digital_marketing_data]
GROUP BY [user_id], [age]
ORDER BY avg_Value DESC
--2. Differences in product preferences between men and women--
 SELECT 
	[gender],
	[product_preference],
	count(*) as SL
FROM [dbo].[starbucks_digital_marketing_data]
group by GROUPING sets (([product_preference],[gender]), ([product_preference]), ([gender]))

--Does app usage vary across geographic regions?
WITH frequency AS (SELECT 
	[user_id],
	[location],
	CASE 
		WHEN [app_usage_frequency] = 'Monthly' THEN 30
		WHEN [app_usage_frequency] = 'Weekly' THEN 7
		WHEN app_usage_frequency = 'Daily' THEN 1
		ELSE 40 END AS app_usage_frequency
FROM [dbo].[starbucks_digital_marketing_data]
)

SELECT 
	DISTINCT([location]),
	AVG(app_usage_frequency) AS app_usage_frequency
FROM frequency
GROUP BY [location]
--3. Digital Marketing---
--order value and social media---
SELECT
	corr([order_value], [social_media_engagement]) as Corr_V_S
FROM [dbo].[starbucks_digital_marketing_data]

--Customers who participate in seasonal campaigns tend to buy which specific products?---
SELECT
	COUNT(CASE 
		WHEN [product_preference] = 'Cappuccino' THEN [product_preference] END) AS T_Cappuccino,
	COUNT(CASE 
		WHEN [product_preference] = 'Iced Coffee' THEN [product_preference] END) AS T_Iced_Coffee,
	COUNT(CASE 
		WHEN [product_preference] = 'Latte' THEN [product_preference] END) AS T_Latte,
	COUNT(CASE 
		WHEN [product_preference] = 'Espresso' THEN [product_preference] END) AS T_Espresso,
	COUNT(CASE 
		WHEN [product_preference] = 'Americano' THEN [product_preference] END) AS T_Americano,
	COUNT(CASE 
		WHEN [product_preference] = 'Local Special' THEN [product_preference] END) AS T_Local_Special
FROM starbucks_digital_marketing_data
WHERE [seasonal_campaign_engagement] <> 0
