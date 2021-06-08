copy staging_caers_events 
FROM '/Users/hjz/Documents/GitHub/hjz130201-homework07/data/CAERS_ASCII_11_14_to_12_17.csv'
with (format csv);
 
SELECT *
FROM staging_caers_events OFFSET 1