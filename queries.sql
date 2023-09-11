-- 1.what is total amount each customer spent on zomato ?
select sales.userid, sum(product.price) as total_spent  from sales inner join product on product.product_id=sales.product_id group by sales.userid order by total_spent desc;
-- 2.How many days has each customer visited zomato?
select userid, count(distinct(created_date)) from sales group by userid;
-- 3.what was the first product purchased by each customer?
with first_product as(
select userid,product_id,created_date, ROW_NUMBER() OVER(PARTITION BY userid order by created_date asc) as rowno from sales order by userid asc,created_date asc)
select * from first_product where rowno<=1;
-- 4.what is most purchased item on menu & how many times was it purchased by all customers ?
select count(*) as total_purchases,product_id from sales group by product_id order by total_purchases desc;
-- 5.which item was most popular for each customer?
with popular_product as(
select userid, product_id, count(*) as c,ROW_NUMBER() OVER(PARTITION BY userid order by count(product_id) desc ) as rno from sales group by userid,product_id order by userid ,c desc)
select * from popular_product where rno<=1;

-- 6.which item was purchased first by customer after they become a member ?

with first_product as(
select sales.userid,sales.product_id,sales.created_date,goldusers_signup.gold_signup_date, ROW_NUMBER() OVER(PARTITION BY sales.userid order by sales.created_date asc) as rowno from sales inner join goldusers_signup on sales.userid =goldusers_signup.userid  where sales.created_date>goldusers_signup.gold_signup_date order by sales.userid asc,sales.created_date asc )
select * from first_product where rowno<=1;


-- 7.what is total orders and amount spent for each member before they become a gold member?
select users.userid,count(sales.product_id),sum(product.price) from users left join goldusers_signup on users.userid=goldusers_signup.userid left join sales on sales.userid=goldusers_signup.userid left join product on product.product_id=sales.product_id  where sales.created_date<goldusers_signup.gold_signup_date group by users.userid ;

-- 8.which item was purchased just before the customer became a member?
with product_before_membership as(
select sales.userid,sales.created_date,goldusers_signup.gold_signup_date,ROW_NUMBER() OVER(PARTITION BY sales.userid order by sales.created_date desc) as row_no from sales inner join goldusers_signup on sales.userid=goldusers_signup.userid where sales.created_date<goldusers_signup.gold_signup_date order by userid )
select * from product_before_membership where row_no<=1;

-- 9.If buying each product generates points for eg 5rs=2 zomato point 
-- --   and each product has different purchasing points for eg for
-- p1 5rs=1 zomato point,for p2 10rs=5 zomato point and p3 5rs=1 zomato
-- point  2rs =1zomato point, calculate points collected by each 
-- customer and for which product most points have been given till now.

select sales.userid,product.product_id,sum(product.price) as total_sales,
case
when product.product_id=1 then (sum(product.price))/5
when product.product_id=2 then (sum(product.price))/2
when product.product_id=3 then (sum(product.price))/5
end as total_points
from product inner join sales on sales.product_id=product.product_id  group by sales.userid,product.product_id order by sales.userid;

-- POINTS COLLECTED BY EACH USER
select userid,sum(total_points) as totalpoints_user from
(select sales.userid,product.product_id,sum(product.price) as total_sales,
case
when product.product_id=1 then (sum(product.price))/5
when product.product_id=2 then (sum(product.price))/2
when product.product_id=3 then (sum(product.price))/5
end as total_points
from product inner join sales on sales.product_id=product.product_id  group by sales.userid,product.product_id order by sales.userid)c group by userid ;

-- product with highest points
select product_id,sum(total_points) as totalpoints_user from
(select sales.userid,product.product_id,sum(product.price) as total_sales,
case
when product.product_id=1 then (sum(product.price))/5
when product.product_id=2 then (sum(product.price))/2
when product.product_id=3 then (sum(product.price))/5
end as total_points
from product inner join sales on sales.product_id=product.product_id  group by sales.userid,product.product_id order by sales.userid)c group by product_id order by totalpoints_user desc limit 1;

-- 10. In the first year after a customer joins the gold program 
-- (including the join date ) irrespective of what customer has 
-- purchased earn 5 zomato points for every 10rs spent who earned 
-- more more 1 or 3 what int earning in first yr ? 1zp = 2rs
select *, totalspent/2 as total_points from(
select sales.userid,sales.product_id,sum(product.price) as totalspent from product inner join sales on sales.product_id=product.product_id inner join goldusers_signup on sales.userid=goldusers_signup.userid  where sales.created_date>=goldusers_signup.gold_signup_date AND sales.created_date<=(goldusers_signup.gold_signup_date + INTERVAL '1 year') group by sales.userid,sales.product_id)c;


-- 11. rnk all transaction of the customers
select sales.userid,sales.product_id,sales.created_date, product.price, ROW_NUMBER() OVER(PARTITION BY sales.userid order by created_date ) as rnk from sales inner join product on sales.product_id=product.product_id order by userid,created_date asc;


