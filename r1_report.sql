-- total cross currency volume in GBP under UK entity b/w 1/4/2022 and 1/8/2023

Select
-- *
count(*) as total_transactions,
    total(Amount_GBP) as total_volume
 from
    Transactions t
left join Customer C
    on t.Customer_ID = C.Customer_ID
where
    ---remove rows with negative amount transacted
    Amount_GBP >0
and
    ---include relevant observation period
    ---(reminder: original file has date in format mm/dd/yyyy)
    (Transaction_Date between '2022-01-04' and '2023-01-08')
and
    ---currency route should involve GBP to be UK entity
    Currency_Route LIKE '%GBP%'
and
    ---address country such be UK to be UK entity
    Current_Address_Country = 'UK'
and
    ---ensuring cross currency
    trim(Start_Currency) != trim(End_Currency)
-- and
--- some transactions have transaction date to be before customer since/join
--- suggesting data quality issue, poor reliability of current_addr_country col
--- however filtering these would mean losing 77% of transactions
--     Transaction_Date>= Customer_Since_Date;
