-- Solution1
CREATE DATABASE e_commerce;
use e_commerce;
 
 CREATE TABLE SUPPLIER(
     SUPP_ID INT unsigned PRIMARY KEY auto_increment, 
     SUPP_NAME VARCHAR(50) NOT NULL, 
     SUPP_CITY VARCHAR(50) NOT NULL, 
     SUPP_PHONE VARCHAR(50) NOT NULL
  );
  
  CREATE TABLE CUSTOMER(CUST_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		CUST_NAME VARCHAR(20) NOT NULL,
		CUST_PHONE VARCHAR(10) NOT NULL, 
		CUST_CITY VARCHAR(30) NOT NULL,
		CUST_GENDER ENUM("M","F") NOT NULL
  );
  
CREATE TABLE CATEGORY(CAT_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		CAT_NAME VARCHAR(20) NOT NULL);
        
CREATE TABLE PRODUCT(PRO_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
       PRO_NAME VARCHAR(20) NOT NULL, 
       PRO_DESC VARCHAR(60), 
       CAT_ID INT UNSIGNED, 
       FOREIGN KEY(CAT_ID) REFERENCES CATEGORY(CAT_ID));

CREATE TABLE SUPPLIER_PRICING(PRICING_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
       PRO_ID INT UNSIGNED, 
       FOREIGN KEY(PRO_ID) REFERENCES PRODUCT(PRO_ID), 
       SUPP_ID INT UNSIGNED, 
       FOREIGN KEY(SUPP_ID) REFERENCES SUPPLIER(SUPP_ID), 
       SUPP_PRICE INT UNSIGNED DEFAULT 0);

CREATE TABLE ORDERS(ORD_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
        ORD_AMOUNT INT UNSIGNED NOT NULL, 
        ORD_DATE DATE NOT NULL,
        CUST_ID INT UNSIGNED, 
        FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(CUST_ID), 
        PRICING_ID INT UNSIGNED,
        FOREIGN KEY(PRICING_ID) REFERENCES supplier_pricing(PRICING_ID));


CREATE TABLE RATING(RAT_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
        ORD_ID INT UNSIGNED, 
        FOREIGN KEY(ORD_ID) REFERENCES ORDERS(ORD_ID), 
        RAT_RATSTARTS INT NOT NULL);
        

-- Solution2
INSERT INTO SUPPLIER (SUPP_NAME, SUPP_CITY,SUPP_PHONE) VALUES("RAJESH RETAILS", "DELHI", 1234567890),
			("APPARIO LTD.", "MUMBAI", 2589631470),
			("KNOME PRODUCTS", "BANGLOARE", 9785462315),
			("BANSAL RETAILS", "KOCHI", 8975463285),
			("MITTAL LTD.", "LUCKNOW", 7898456532);

INSERT INTO CUSTOMER (CUST_NAME,CUST_PHONE,CUST_CITY,CUST_GENDER) VALUES("AAKASH",9999999999, "DELHI","M"),
		("AMAN",9785463215, "NOIDA","M"),
		("NEHA",9999999999, "MUMBAI","F"),
		("MEGHA",9994562399, "KOLKATA","F"),
		("PULKIT",7895999999, "LUCKNOW","M");

INSERT INTO CATEGORY(CAT_NAME) VALUES("BOOKS"),
		("GAMES"),
		("GROCERIES"),
		("ELECTRONICS"),
		("CLOTHES");
        
INSERT INTO PRODUCT(PRO_NAME,PRO_DESC,CAT_ID) VALUES
			("GTA V","Windows 7 & above with i5 processor and 8GB RAM",2),
			("TSHIRT","SIZE-L with Black,Blue and White variations",5),
			("ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4),
			("OATS","Highly Nutritious from Nestle",3),
			("HARRY POTTER","Best Collection of all time by J. K Rowling",1),
			("Milk","1L Toned Milk",3),
			("Boat Earphones","1.5Meter long Dolby Atoms",4),
			("Jeans","Stretchable Denim Jeans with various sizes and color",5),
			("Project IGI","comaptible with windows 7 and above",2),
			("Hoodie","Black GUCCI for 13 yrs and above",5),
			("Rich Dad Poor Dad","Written by RObert Kiyosaki",1),
			("Train Your Brain","By Shireen Stephen",1);
            
INSERT INTO SUPPLIER_PRICING (PRO_ID,SUPP_ID,SUPP_PRICE) VALUES(1, 2, 1500),
			(3, 5, 30000),
			(5, 1, 3000),
            (2, 3, 2500),
			(4, 1, 1000),
			(12, 2, 780),
			(12, 4, 789),
			(3, 1, 31000),
			(1, 5, 1450),
			(4, 2, 999),
			(7, 3, 549),
			(7, 4, 529),
			(6, 2, 105),
			(6, 1, 99),
			(2, 5, 2999),
			(5, 2, 2999);

INSERT INTO ORDERS(ORD_ID,ORD_AMOUNT,ORD_DATE,CUST_ID,PRICING_ID) VALUES
		(101,1500, "2021-10-06",2,1),
		(102,1000, "2021-10-12",3,5),
		(103,30000, "2021-09-16",5,2),
		(104,1500, "2021-10-05",1,1),
 		(105,3000, "2021-08-16",4,3),
		(106,1450, "2021-08-18",1,9),
		(107,789, "2021-09-01",3,7),
		(108,780,"2021-09-07",5,6),
		(109,3000, "2021-09-10",5,3),
		(110,2500, "2021-09-10",2,4),
		(111,1000, "2021-09-15",4,5),
		(112,789, "2021-09-16",4,7),
		(113,31000, "2021-09-16",1,8),
		(114,1000, "2021-09-16",3,5),
		(115,3000, "2021-09-16",5,3),
		(116,99, "2021-09-17",2,14);

INSERT INTO RATING(ORD_ID,RAT_RATSTARTS) VALUES
		(101,4),
		(102,3),
		(103,1),
		(104,2),
		(105,4),
		(106,3),
		(107,4),
		(108,4),
		(109,3),
		(110,5),
		(111,3),
		(112,4),
		(113,2),
		(114,1),
		(115,1),
		(116,0);


-- Solution4 
SELECT cust_gender, COUNT(DISTINCT customer.cust_id) as TotalCustomers
FROM customer
JOIN orders ON customer.cust_id = orders.cust_id
WHERE orders.ORD_AMOUNT >= 3000
GROUP BY cust_gender;
       
-- SELECT CUST_GENDER, COUNT(*) AS TotalCustomers
-- FROM customer
-- INNER JOIN orders ON customer.CUST_ID = orders.CUST_ID
-- WHERE ORD_AMOUNT >= 3000
-- GROUP BY CUST_GENDER;



-- Solution5
select cust_name, cust_city, o.ORD_AMOUNT, o.pricing_id, s.PRO_ID, p.PRO_NAME, p.PRO_DESC
   from customer inner join orders as o 
     on customer.cust_id=o.CUST_ID 
     inner join supplier_pricing as s
       on o.PRICING_ID = s.PRICING_ID
     inner join product as p
       on s.PRO_ID=p.PRO_ID
     and customer.cust_id=2;
     
-- SELECT O.ORD_ID, P.PRO_NAME
-- FROM orders O
-- INNER JOIN product P ON O.PRICING_ID = P.PRO_ID
-- WHERE O.CUST_ID = 2;


-- Solution6

select s.supp_name, count(p.PRO_NAME) as num_of_products from supplier as s inner join supplier_pricing as sp on s.SUPP_ID=sp.SUPP_ID
        inner join product as p on sp.PRO_ID=p.PRO_ID
        group by s.SUPP_NAME
        having num_of_products > 1;

-- SELECT S.SUPP_ID, S.SUPP_NAME
-- FROM supplier S
-- INNER JOIN supplier_pricing SP ON S.SUPP_ID = SP.SUPP_ID
-- GROUP BY S.SUPP_ID, S.SUPP_NAME
-- HAVING COUNT(SP.PRO_ID) > 1;


-- Solution7
SELECT C.CAT_ID, C.CAT_NAME, P.PRO_NAME, SP.SUPP_PRICE
FROM category C
INNER JOIN product P ON C.CAT_ID = P.CAT_ID
INNER JOIN supplier_pricing SP ON P.PRO_ID = SP.PRO_ID
WHERE SP.SUPP_PRICE = (
    SELECT MIN(SUPP_PRICE)
    FROM supplier_pricing SP2
    WHERE SP2.PRO_ID = P.PRO_ID
)
ORDER BY C.CAT_ID;


-- Solution8

select p.pro_id, p.pro_name from orders as o inner join supplier_pricing as sp 
         on o.PRICING_ID=sp.PRICING_ID
     inner join product as p on sp.pro_id=p.PRO_ID   
     inner join customer as c
       on o.CUST_ID=c.cust_id
    where o.ORD_DATE > "2021-10-05"; 

-- SELECT P.PRO_ID, P.PRO_NAME
-- FROM product P
-- INNER JOIN supplier_pricing SP ON P.PRO_ID = SP.PRO_ID
-- INNER JOIN orders O ON SP.PRICING_ID = O.PRICING_ID
-- WHERE O.ORD_DATE > '2021-10-05';


-- Solution9
SELECT CUST_NAME, CUST_GENDER
FROM customer
WHERE CUST_NAME LIKE 'A%' OR CUST_NAME LIKE '%A';


-- Solution10
DELIMITER //
CREATE PROCEDURE GetSupplierServices()
BEGIN
    SELECT supplier.SUPP_ID, supplier.SUPP_NAME, rating.RAT_RATSTARTS,
        CASE
            WHEN rating.RAT_RATSTARTS = 5 THEN 'Excellent Service'
            WHEN rating.RAT_RATSTARTS > 4 THEN 'Good Service'
            WHEN rating.RAT_RATSTARTS > 2 THEN 'Average Service'
            ELSE 'Poor Service'
        END AS Type_of_Service
    FROM supplier
    INNER JOIN rating ON supplier.SUPP_ID = rating.RAT_ID;
END //
DELIMITER ;

CALL GetSupplierServices();




