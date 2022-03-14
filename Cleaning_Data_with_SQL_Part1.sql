/****** Script for SelectTopNRows command from SSMS  ******/
select *
into sba_naics_sector_code_description
from(

SELECT  
		[NAICS_Industry_Description],
		iif([NAICS_Industry_Description] Like '% Ð %', substring([NAICS_Industry_Description],8,2), '') as LookupCodes,
		iif([NAICS_Industry_Description] Like '% Ð %', ltrim(substring([NAICS_Industry_Description], CHARINDEX ('Ð',[NAICS_Industry_Description]) + 1, LEN([NAICS_Industry_Description]))),'')Sector
		--case when [NAICS_Industry_Description] Like '% Ð %' then substring([NAICS_Industry_Description],8,2) end LookupCodes_if
  FROM [PortfolioDB].[dbo].[sba_industry_standards]
  where [NAICS_Codes] =''
  ) main
  where
      LookupCodes != ''

	  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [NAICS_Industry_Description]
      ,[LookupCodes]
      ,[Sector]
  FROM [PortfolioDB].[dbo].[sba_naics_sector_code_description]

  insert into [PortfolioDB].[dbo].[sba_naics_sector_code_description]
  values
  ('Sector 31 - 33 - Manufacturing',  32, 'Manufacturing'),  
  ('Sector 31 - 33 - Manufacturing',  33, 'Manufacturing'),
  ('Sector 44 - 45 - Retail Trade', 45, 'Retail Trade'),
  ('Sector 48 - 49 - Transportation and warehousing',  49, 'Transportation and warehousing')

Update [PortfolioDB].[dbo].[sba_naics_sector_code_description]
  set Sector = 'Manufacturing'
  where LookupCodes = 31
  

