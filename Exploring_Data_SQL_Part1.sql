/****** Script for SelectTopNRows command from SSMS  ******/
 ---What is the summary of all approved PPP Loans
  SELECT
	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM [PortfolioDB].[dbo].[sba_public_data]

  ---How much PPP Loan was given in 2020 and 2021
  
  SELECT
    year (DateApproved) as year_approved,
	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
  [PortfolioDB].[dbo].[sba_public_data]

  Where
  year(DateApproved) = 2020

  group by
  year (DateApproved)

   SELECT
    year (DateApproved) as year_approved,
	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
  [PortfolioDB].[dbo].[sba_public_data]

  Where
  year(DateApproved) = 2021

  group by
  year (DateApproved)

 --- finding out the unique lenders
  SELECT
  count(distinct [OriginatingLender]) OriginatingLender,
    year (DateApproved) as year_approved,
	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
  [PortfolioDB].[dbo].[sba_public_data]

  Where
  year(DateApproved) = 2020

  group by
  year (DateApproved)

   SELECT
    count(distinct [OriginatingLender]) OriginatingLender,
    year (DateApproved) as year_approved,
	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
  [PortfolioDB].[dbo].[sba_public_data]

  Where
  year(DateApproved) = 2021

  group by
  year (DateApproved)

  -----Top 15 originating lenders count, total amount and average in 2020 and 2021
  
   SELECT top 15   OriginatingLender,

	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
		[PortfolioDB].[dbo].[sba_public_data]
  Where
		year(DateApproved) = 2020
  group by
  OriginatingLender
 order by 3 desc;
 
 SELECT top 15  OriginatingLender,

	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
		[PortfolioDB].[dbo].[sba_public_data]
  Where
		year(DateApproved) = 2021
  group by
  OriginatingLender
 order by 3 desc;
 
 --- Top 20 industries that received the PPP Loans in 2020 and 2021
 ----Join
 SELECT top 20 d.Sector,

	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
		[PortfolioDB].[dbo].[sba_public_data] p
		inner join [dbo].[sba_naics_sector_code_description] d
		on left(p.NAICSCode, 2) = d.LookupCodes
  Where
		year(DateApproved) = 2021
  group by
   d.Sector
 order by Average_loan_size desc;

  SELECT top 20 d.Sector,

	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
		[PortfolioDB].[dbo].[sba_public_data] p
		inner join [dbo].[sba_naics_sector_code_description] d
		on left(p.NAICSCode, 2) = d.LookupCodes
  Where
		year(DateApproved) = 2020
  group by
   d.Sector
 order by Average_loan_size desc;

 ---- calculating percentage using sub query
 
 ;with cte as  ---- The CTE Act like a table
 ( 
 SELECT top 20 d.Sector,

	count (LoanNumber) as Number_of_Approved,
	sum(InitialApprovalAmount) as Approved_Amount,
	avg(InitialApprovalAmount) as Average_loan_size
  FROM 
		[PortfolioDB].[dbo].[sba_public_data] p
		inner join [dbo].[sba_naics_sector_code_description] d
		on left(p.NAICSCode, 2) = d.LookupCodes
  Where
		year(DateApproved) = 2020
  group by
   d.Sector
 )
 select Sector,Number_of_Approved, Approved_Amount,Average_loan_size,
 Approved_Amount/sum(Approved_Amount) over() *100  as Percent_by_Amount ---- using window function
 from cte
 order by Approved_Amount desc

 ----How much of the ppp loans of 2021 have been fully forgiven

 
   SELECT 
	count (LoanNumber) as Number_of_Approved,
	sum(CurrentApprovalAmount) as current_Approved_Amount,
	avg(CurrentApprovalAmount) asCurrent_Average_loan_size,
	sum(ForgivenessAmount) as Amount_forgiven,
	sum(ForgivenessAmount)/sum (CurrentApprovalAmount) *100 as Percent_forgiven
  FROM 
		[PortfolioDB].[dbo].[sba_public_data]
  Where
		year(DateApproved) = 2020
  
 order by   Number_of_Approved

  SELECT 
	count (LoanNumber) as Number_of_Approved,
	sum(CurrentApprovalAmount) as current_Approved_Amount,
	avg(CurrentApprovalAmount) asCurrent_Average_loan_size,
	sum(ForgivenessAmount) as Amount_forgiven,
	sum(ForgivenessAmount)/sum (CurrentApprovalAmount) *100 as Percent_forgiven
  FROM 
		[PortfolioDB].[dbo].[sba_public_data]
  Where
		year(DateApproved) = 2021
  
 order by   Number_of_Approved

  ----How much of the ppp loans of 2021 have been fully forgiven
   SELECT 
	year (DateApproved) as Year_Approved,
	Month (DateApproved) as Month_approved,
	Count (LoanNumber) as Number_of_approved,
	sum(InitialApprovalAmount) as Total_net_Dollars,
	avg(InitialApprovalAmount) Average_loan_size
  FROM 
		[PortfolioDB].[dbo].[sba_public_data]
  group by
		year(DateApproved),
		month(DateApproved)
  
 order by    Total_net_Dollars
