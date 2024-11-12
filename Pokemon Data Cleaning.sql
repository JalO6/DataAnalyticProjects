-- Data Cleaning
-- 1. Remove Duplicates
-- 2. Standardize Data
-- 3. Null Values or Blank Values
-- 4. Remove Unecessary Columns and Rows

Select *
FROM pokedex_staging;

-- Make Identifier Column
Select *,
ROW_NUMBER() OVER(
PARTITION BY pokedex_number, `name`, generation, type_1, type_2) AS row_num
FROM pokedex_staging;

-- Check For Duplicates
WITH duplicate_cte AS 
(
Select *,
ROW_NUMBER() OVER(
PARTITION BY pokedex_number, `name`, generation, type_1, type_2) AS row_num
FROM pokedex_staging
)
Select *
From duplicate_cte
WHERE row_num > 1;

-- Standardizing Data
-- Takes Out Whitespace
SELECT `name`, TRIM(`name`)
FROM pokedex_staging;

UPDATE pokedex_staging
SET `name` = TRIM(`name`);

-- Fixing the word Pokemon
-- %name% wildcard for anywhere
Select * 
FROM pokedex_staging
WHERE species Like '%PokÃ©mon%';

UPDATE pokedex_staging
SET species = replace (species, 'PokÃ©mon', 'Pokemon');

Select * 
FROM pokedex_staging

