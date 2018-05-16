
-- scalar functions. take one record as input, "scale" or change it in some way, get one record as output
select name from artist where upper(name) like 'A %';
select name from artist where lower(name) like 't_e%';
select name from artist where length(name) < 10;
select name from artist where lower(name) like '%s';
select nam

-- aggregate functions, perform function on entire column/set of data --
select max(albumid) from album;
select count(*) from artist;
select avg(total) from invoice;
select min(total) from invoice;
select max(total) from invoice;

select * from album;

--NESTED QUERIES

-- find Foo fighters' albums 
select albumid, title
from album 
where artistid = 
(select artistid from artist where name = 'Foo Fighters');

-- when subquery returns more than one entity, use IN to signify that the id is "IN" this set of results
select name as "Track Name"
from track 
where genreid IN (select genreid from genre where name like 'R%');


select count(*) from track;

select * from genre;

-- DUAL -- dummy table in Oracle SQL; exists to maintain SELECT syntax when reading stored entity 
select sysdate from dual;

-----------------------------------------------------------------------J O I N S ------------------------------------------------------------------------------------------
-- INNER JOIN
select * from playlisttrack;


select g.name as genre, count(tr.name) as track
from track tr
inner join genre g 
on tr.GENREID = g.GENREID
group by g.name
--having count(tr.name) > 100  -- having can only be used with group by 
order by g.name;

select * 
from album al
join artist art on art.artistid = al.artistid
join track tr on tr.ALBUMID = al.ALBUMID
join genre g on g.GENREID = tr.GENREID
join PLAYLISTTRACK plt on plt.TRACKID = tr.trackid
join playlist pl on pl.PLAYLISTID = plt.PLAYLISTID
join invoiceline inl on inl.TRACKID = tr.TRACKID
join invoice inv on inl.INVOICEID = inv.INVOICEID
join mediatype mt on mt.MEDIATYPEID = tr.MEDIATYPEID
join customer cust on cust.CUSTOMERID = inv.CUSTOMERID
join EMPLOYEE emp on emp.EMPLOYEEID = cust.SUPPORTREPID
order by tr.name;




select avg(unitprice) from invoiceline;

-- cross join - cartesian product of two tables
select * from artist, album;

-- natural join -- where Oracle SQL attempts to match based on column names
select * from artist natural join album;
select * from artist inner join album on artist.ARTISTID = album.ARTISTID;

-- self join -- joining columns from same table, here we join the reports to column with the manager column
select  e1.lastname as "MANAGER", e2.lastname as "EMPLOYEE"
from employee e1 
inner join employee e2 on e1.reportsto = e2.employeeid;

------ SET OPERATIONS
/* Used to combine result set (must have the same columns)
    Union - all unique rows
    Union all - all rows, including duplicates
    intersect - what the 2 result sets have in common 
    minus - what result set A has that result set B does not 
*/

-- UNION & UNION ALL 
select * From customer where firstname like 'L%'; -- ID - 1, 2, 45, 47, 57
select * from Customer where state = 'CA'; -- Customer id 16, 19, 20
select * from customer where country = 'Brazil'; -- ID - 1, 10, 11, 12, 13
select * from Customer where state = 'CA' UNION select * from customer where country = 'Brazil';
select * From customer where firstname like 'L%' union all select * from customer where country = 'Brazil';

-- INTERSECT / MINUS
select * from invoiceline where unitprice > .99;
select * from invoiceline where trackid  < 3000;
select * from invoiceline where unitprice > .99 minus select * from invoiceline where trackid  < 3000; 