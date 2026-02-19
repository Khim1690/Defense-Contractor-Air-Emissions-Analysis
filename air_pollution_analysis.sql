SELECT * FROM khimdb.air_pollution;
select*from air_pollution
limit 5;  

### Emissions by state
SELECT state,
       ROUND(SUM(air_emissions_lbs), 2) AS total_emissions
FROM air_pollution
GROUP BY state
ORDER BY total_emissions DESC;



## Total air pollution emissions by company

SELECT parent_company,
       ROUND(SUM(air_emissions_lbs), 2) AS total_emissions
FROM air_pollution
GROUP BY parent_company
ORDER BY total_emissions DESC;


## top 10 chemicals
select chemical,
  ROUND(SUM(air_emissions_lbs), 2) AS total_emissions
  from air_pollution
  group by chemical
  order by total_emissions desc
  limit 10;



##top 10 polluting facilities
SELECT facility_name,
       ROUND(SUM(air_emissions_lbs), 2) AS total_emissions
FROM air_pollution
GROUP BY facility_name
ORDER BY total_emissions DESC
LIMIT 10;


### which company emits the most per facility
SELECT parent_company,
       ROUND(AVG(air_emissions_lbs), 2) AS avg_emission_per_record
FROM air_pollution
GROUP BY parent_company
ORDER BY avg_emission_per_record DESC;


##No 1 Chemical per company
SELECT *
FROM (
    SELECT parent_company,
           chemical,
           SUM(air_emissions_lbs) AS total_emissions,
           RANK() OVER (PARTITION BY parent_company 
                        ORDER BY SUM(air_emissions_lbs) DESC) AS rnk
    FROM air_pollution
    GROUP BY parent_company, chemical
) ranked
WHERE rnk = 1;






