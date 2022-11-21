
---- AWESOME CHOCOLATES DATA ANALYSIS---


-- VIEWING ALL THE TABLES--

show tables;


--- viewing the data-------

select geoid,geo,region from geo;



select pid,product,category,size,cost_per_box from products;



--- ranking spid based on the sales of product ---

select spid,total,product,dense_rank() over(partition by spid order by total desc) as r from(
select s.SPID,s.boxes,sum(s.amount) total,p.product
from sales as s join products p on
s.PID=p.pid
group by s.spid,p.product)as t;



--- ranking spid based on the sales location ---

select location,team,spid,total from (
    select p.location,p.team,p.spid,sum(s.amount) as total
	from people p join sales s on 
	p.spid=s.spid
    group by p.Location,p.team,p.spid
    order by p.location
    ) as tamount;
	
   
--- gettig the number of boxes, number of customers,and total amount of products based on box size ---
   
select p.size,p.Product,sum(s.boxes),sum(s.Customers),sum(amount)
from products p join sales s on
p.PID=s.PID
group by p.Size,p.product
order by size;


   
---total sales for each salesperson(spid) and ranking them ---
   
 
select spid,total,dense_rank() over(order by total desc) as r 
from (
select spid,sum(amount) as total from
sales
group by spid) as t;



   
---total customers for each spid and ranking them ---

   select spid,total, dense_rank() over (order by total desc) as r from(
   select spid,sum(Customers) as total
   from sales
   group by spid) as s;
   


 
--- Ranking the product sales based on the geo location---

select geo,product,total,dense_rank() over (partition by geo order by total desc)  as r from (
select g.geo,p.product,sum(s.amount) as total
from products p join sales s on p.PID=s.PID
join geo g on g.geoid=s.geoid
group by g.geo,p.product
order by g.geo) as sumt;




--- finding the average cost per box of each product---

select product,avg(cost_per_box) as avg_cost
from products
group by product
order by avg_cost desc;




--- for each location getting sales based on box size ---
select pr.size,p.location,sum(s.amount)
from products pr join sales s on
pr.pid=s.PID
join people p on p.spid=s.spid
group by pr.size,p.location
order by size;




--- for each geo location getting sales based on box size---

select pr.size,g.geo,sum(s.amount)
from products pr join sales s on
pr.pid=s.PID
join geo g on g.GeoID=s.GeoId
group by pr.size,g.geo
order by size;




--- total sales for each product category on different geo locations ---

select category,geo,sum(boxes)
from products pr join sales s on
pr.pid=s.pid
join geo g on s.GeoID=g.geoid
group by pr.Category,g.geo
order by category;




--- monthly boxes sold for each region ---

select salemonth,region,totalboxes, dense_rank() over ( partition by region order by totalboxes desc) as top_positions from(
select s.saledate,g.region,DATE_FORMAT(s.saledate,'%Y-%M')as salemonth,sum(s.boxes) as totalboxes
from sales s
join geo g on s.geoid=g.geoid
group by salemonth,g.region
) as t;





   
   
   
   
   
    
