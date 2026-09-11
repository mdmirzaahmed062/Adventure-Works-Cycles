use adventure_works;
select * from dimcustomer;
select * from dimdate;
select * from dimproduct;
select * from dimproductcategory;
select * from dimproductsubcategory;
select * from fact_internet_sales_new;
select * from factinternetsales;
select * from dimsalesterritory;
select * from sales;


# Union of tables



create table Sales as
select *
from factinternetsales
union 
select *
from fact_internet_sales_new;

select * from Sales;

select * from dimcustomer;
alter table dimcustomer add primary key(customerkey);

# relationship between sales and dimcustomer
alter table sales
add constraint fk_sales_customer
foreign key (customerkey)
references dimcustomer(customerkey);

# relationship between sales and dimdate

describe dimdate;

select * from dimdate;

select * from Sales;
alter table dimdate modify DateKey int primary key not null unique;
describe sales;
alter table sales
add constraint fk_sales_date
foreign key(orderdatekey)
references dimdate(datekey);


# relationship between sales and dimsalesterritory
describe dimsalesterritory;
alter table dimsalesterritory modify SalesTerritoryKey int not null unique primary key;

alter	table sales add constraint fk_sales_territory
foreign key(salesterritorykey)
references dimsalesterritory(salesterritorykey);

# relationship between dimproductsubcategory and dimproductcategory
alter table dimproductcategory modify ProductCategoryKey int primary key;
alter table dimproductsubcategory modify ProductSubcategoryKey int primary key;
alter table dimproductsubcategory add productcategorykey int;

describe dimproductcategory;
describe dimproductsubcategory;

select * from dimproductsubcategory;
alter table dimproductcategory add constraint fk1_prodcat2
foreign key(productcategorykey)
references dimproductsubcategory(productsubcategorykey);

# relationship between dimproduct and dimproductsubcategory

update dimproduct set productsubcategorykey=null
where productsubcategorykey=0;
alter table dimproduct modify ProductSubcategoryKey int;
describe dimproduct;
select * from dimproduct;
alter table dimproduct add constraint fkproductsubcat
foreign key (productsubcategorykey)
references dimproductsubcategory(productsubcategorykey);
alter table dimproduct modify ProductKey int primary key;


# relationship between sales and dimproduct
describe sales;
select * from sales;
select * from dimproduct;
delete from dimproduct where ProductKey is null;
alter table sales add constraint fk_salesprodu
foreign key(productkey)
references dimproduct(productkey);
alter table sales modify ProductKey int primary key;

insert	into dimproduct(ProductKey,EnglishProductName)
select distinct s.ProductKey,"unknown"
from sales s
left join dimproduct p
on s.ProductKey=p.ProductKey
where p.ProductKey is null;
                        
# lookup product name from product table to sales table                        
                        
SELECT P.EnglishProductName
FROM dimproduct p
left join sales s
on s.ProductKey=p.ProductKey;

update sales s
join dimproduct p
on s.productkey=p.productkey
set s.productname=p.englishproductname;

alter table sales add productname varchar(200);

select * from sales;

                        
# lookup customer full name from customer table to sales table                        

select * from dimcustomer;
alter table sales add Customer_full_name varchar(200);
alter table dimcustomer add Customer_full_name varchar(200);


update dimcustomer 
set customer_full_name=concat(firstname," ",middlename," ",lastname);


update sales s
join dimcustomer c
on s.customerkey=c.customerkey
set s.customer_full_name=c.customer_full_name;



# lookup unit price from product table to sales table                        
select * from dimproduct;
select * from sales;
describe sales;
update dimproduct
set `Unit price`= null
where `unit price` =" ";
alter table dimproduct modify `unit price` decimal;
alter table sales add Unitprice decimal; 


# date field from the orderdatekey


alter table sales add Date date;


update sales set date=str_to_date(orderdatekey,"%Y%m%d");
select * from sales;
 
#  year

alter table sales modify year int;

update sales set year=year(date);
select * from sales;

# MONTH NO

alter table sales add monthno int;

update sales set monthno=month(date);
select * from sales;
 
 # month full name
 
 alter table sales add monthfullname varchar(100);
 
 update sales 
 set monthfullname=monthname(date);
 select * from sales;
 
 alter table sales add Quarter varchar(10);
 
 update sales set quarter=concat("Q",quarter(str_to_date(orderdatekey,'%Y%m%d')));
 select * from sales;
 
 # year month 
 
 alter table Sales add Yearmonth varchar(100);
 update sales set yearmonth=date_format(date,"%Y-%m");
 select * from sales;
 
 # weekday no
 
 alter table Sales add weekdayno varchar(100);
 update sales set weekdayno=weekday(date)+1;
 select * from sales;
 
 #weekday name
 
 alter table Sales add weekdayname varchar(100);
 
 update sales set weekdayname=dayname(date);
 select * from sales;
 
 #financial month
 
 alter table Sales add Financialmonth int;
 
 update sales set financialmonth=case 
									when month(date)>=7 then 
                                    month(date)-6
                                    else month(date)+6
                                    end;

select * from sales;

   # Financial Quarter 

alter table sales add FinancialQuarter varchar(10);

update sales set financialquarter=case
										when month(date) between 7 and 9 then "Q1"
                                        when month(date) between 10 and 12 then "Q2"
                                        when month(date) between 1 and 3 then "Q3"
                                        else "Q4"
                                        end ;


select * from sales;
 
 
 # production cost
 
 
 alter table sales add productioncost decimal(12,2);
 
 update sales set productioncost=productstandardcost*orderquantity;
 
 select * from sales;
 
 # profit
 
 alter table sales add profit decimal(12,2);
 
 update sales set profit=salesamount-productioncost;
 
 select * from sales;
 
 
 
 
 
							# year wise sales
                            

select year,concat(round(sum(salesamount)/1000000,2),"M") as total_Sales
from sales
group by year
order by year;



						# Quarterwise sales
                        

select quarter,concat(round(sum(salesamount)/1000000,2),"M") as total_sales
from sales
group by quarter
order by quarter;


								#month wise sales
                                
                                

select monthfullname,concat(round(sum(salesamount)/1000000,2),"M") as total_sales
from sales
group by monthfullname
order by monthfullname;



												# sum of sales
                                                
select concat(round(sum(salesamount)/1000000,2),"M")
from sales;


												# sum of profit
	
    
select concat(round(sum(profit)/1000000,2),"M")
from sales;


										# sum of profit yearwise
                                        
select year,concat(round(sum(salesamount)/1000000,2),"M") as total_profit
from sales
group by year
order by year;



												#  monthwise  profit

select monthno,concat(round(sum(salesamount)/1000000,2),"M") as total_profit
from sales
group by monthno
order by  monthno;




									# customers
                                    

select concat(round(count(DISTINCT(customer_full_name))/1000,3),"K") as total_customers
from sales;




										# sum of product
                                        
select count(distinct(EnglishProductName)) as customers
from dimproduct;



												# sales by product
                                                
                                                
select p.englishproductname,concat(round(sum(s.salesamount)/1000000,2),"M") as total_sales
from sales s
join dimproduct p
on s.ProductKey=p.ProductKey
group by EnglishProductName
order by EnglishProductName asc;




								# top 10 productwise sales
                                

select p.englishproductname,concat(round(sum(s.salesamount)/1000000,2),"M") as total_sales
from sales s
join dimproduct p
on s.ProductKey=p.ProductKey
group by EnglishProductName
limit 10;





								# rigion wise sales
                                
                                
                           select * from dimsalesterritory;     

select t.SalesTerritoryregion,concat(round(sum(s.salesamount)/1000000,2),"M") as total_sales
from sales s
join dimsalesterritory t
on s.SalesTerritoryKey=t.SalesTerritoryKey
group by salesterritoryregion
order by SalesTerritoryRegion asc;
