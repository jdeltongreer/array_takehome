-- Assignment 4
-- You've been asked to demonstrate to a junior engineer the use of CTEs. Write a query that would identify clients that have done over 100 reports in the last 30 days. 
-- The query should return the client's name and the number of reports within the last 30 days.

DECLARE @MAX_DATE_LOOKBACK INT
DECLARE @ORDER_MINIMUM INT
SET @MAX_DATE_LOOKBACK = DATEADD(DAY, -30, GETDATE())
SET @ORDER_MINIMUM = 100

WITH SEARCH_DATA AS (
    SELECT ORDER_ID
        ,ORDER_DATE
        ,CLIENT_ID
    FROM [ORDER]
    WHERE ORDER_DATE >= @MAX_DATE_LOOKBACK
)

SELECT CLIENT_ID
    ,CLIENT_NAME
    ,COUNT(CLIENT_ID) AS TOTAL_ORDERED
FROM SEARCH_DATA SDAT
LEFT JOIN CLIENT CLNT
    ON SDAT.CLIENT_ID = CLNT.CLIENT_ID
GROUP BY CLIENT_ID
    ,CLIENT_NAME
HAVING COUNT(CLIENT_ID) >= @ORDER_MINIMUM

