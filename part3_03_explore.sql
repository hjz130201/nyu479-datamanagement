-- 1. this query tries to determine whether or not report id is unique
select count(distinct Report_ID), count(Report_ID)
from staging_caers_events;
--the two count is not the same; hence not unique
---
--- count | count  
----------+--------
--- 84564 | 100881
---

-- 2. to see the two columns relationship
with c1c2 as (select distinct report_id, product_type from staging_caers_events)
select case when Exists(Select 1 From c1c2 Group By report_id Having Count(*) > 1) 
and Exists(Select 1 From c1c2 Group By product_type Having Count(*) > 1) 
then  'Many to Many' else 'No' end as result;
--     result    
--------------
--  Many to Many
-- (1 row)

-- 3. see if Product_Code and report_id can add together to become unique values
select count(distinct a.uniquemaybe), count(a.uniquemaybe) 
from (select concat(Product_Code,report_id) as uniquemaybe from staging_caers_events) as a;

-- count | count  
-------+--------
-- 86775 | 100881
--(1 row)

--4. counting null values in some columns
SELECT COUNT(*)-COUNT(Date_of_Event) As Date_of_Event, COUNT(*)-COUNT(Description) As Description, COUNT(*)-COUNT(Outcomes) As Outcomes
FROM staging_caers_events;

---date_of_event | description | outcomes 
---------------+-------------+----------
---         72860 |       50458 |    50440
---(1 row)

