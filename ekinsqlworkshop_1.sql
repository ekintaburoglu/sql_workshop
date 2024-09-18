# ekin-taburoglu-sql-ders-1
sql sorgu




--SELECT * FROM Products  WHERE supplierid BETWEEN 1 and 5
--SELECT * FROM Products WHERE supplierid IN (1, 2, 4, 5)
--SELECT * FROM Products WHERE productname IN ('Chang', 'Aniseed Syrup')
--SELECT * FROM Products WHERE supplierid = 3 OR unitprice > 10
--SELECT productname, unitprice FROM ProductSELECT productname || ' - ' || unitprice || ' ₺' AS "Ürün & Fiyatlar" FROM Products
--SELECT productname FROM Products WHERE UPPER(productname) LIKE '%C%'

--SELECT * FROM Products WHERE unitsinstock > 50
--SELECT MAX(unitprice) AS "En Yüksek Fiyat", MIN(unitprice) AS "En Düşük Fiyat" FROM Products
--SELECT * FROM Products WHERE productname LIKE '%Spice%'