--R2
--2
--total same-currency volume in GBP under US entity between 1/4/2022 and 1/8/2023
Select
*
-- count(*) as total_transactions,
--     total(Amount_GBP) as total_volume
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
    -- US entity
    (
        trim(Start_Currency) ='USD'
        or
        Current_Address_Country = 'USA'
    )
and
    ---ensuring same currency
     trim(Start_Currency) = trim(End_Currency)
