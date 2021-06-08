create table event (  
    Report_ID text,
    CAERS_Created_Date text,
    Date_of_Event text
);

INSERT INTO event 
SELECT Report_ID, CAERS_Created_Date, Date_of_Event
FROM staging_caers_events;

create table product(
    Product_Type text,
    Product text,
    Product_Code text,
    Description text
);
INSERT INTO product 
SELECT Product_Type, Product, Product_Code, Description
FROM staging_caers_events;

create table patient(
    Patient_Age text,
    Age_Units text,
    Sex text,
    Medra_Preferred_Terms text,
    Outcomes text
);

INSERT INTO patient 
SELECT Patient_Age, Age_Units, Sex, Medra_Preferred_Terms, Outcomes
FROM staging_caers_events;