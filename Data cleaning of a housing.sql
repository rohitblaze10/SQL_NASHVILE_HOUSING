--select * 
--from nashvilehousing

-------------
--select saledate,convert(date,saledate)
--from nashvilehousing


alter table nashvilehousing
add newsalesdate date;

--update nashvilehousing
--set newsalesdate=convert(date,saledate)

--select newsalesdate,convert(date,saledate)
--from nashvilehousing

--------------------------

select propertyaddress
from portfolioproject..nashvilehousing
--where propertyaddress is null
order by ParcelID

select a1.ParcelID,a1.[PropertyAddress],a2.ParcelID,a2.PropertyAddress,ISNULL(a1.propertyaddress,a2.propertyaddress)
from portfolioproject..nashvilehousing a1
join portfolioproject..nashvilehousing a2
on a1.ParcelID=a2.ParcelID
and a1.[UniqueID ] != a2.[UniqueID ]
where a1.propertyaddress is null

update a1
set a1.PropertyAddress=ISNULL(a1.propertyaddress,a2.propertyaddress)

from portfolioproject..nashvilehousing a1
join portfolioproject..nashvilehousing a2
on a1.ParcelID=a2.ParcelID
and a1.[UniqueID ] != a2.[UniqueID ]
where a1.propertyaddress is null

select *  
from portfolioproject..nashvilehousing a1
where propertyaddress is null
---------------
select 
substring(propertyaddress,1,CHARINDEX(',',propertyaddress)) as address,
substring(propertyaddress,CHARINDEX(',',propertyaddress)+1,len(propertyaddress)) as address
from portfolioproject..nashvilehousing



alter table nashvilehousing
add propertylocation nvarchar(255);

update nashvilehousing
set propertylocation=substring(propertyaddress,1,CHARINDEX(',',propertyaddress))
----------------------------------------------------------------
--ALTER TABLE nashvilehousing               i used for a mistake
--                                                in a column
--DROP COLUMN propertycity;
----------------------------------------------------------------
alter table nashvilehousing
add propertycity nvarchar(255);

update nashvilehousing
set propertycity =substring(propertyaddress,CHARINDEX(',',propertyaddress)+1,len(propertyaddress))


select *  
from portfolioproject..nashvilehousing









select 
parsename(replace(owneraddress,',','.'),3),
parsename(replace(owneraddress,',','.'),2),
parsename(replace(owneraddress,',','.'),1)
from portfolioproject..nashvilehousing

alter table nashvilehousing
add ownernewaddress nvarchar(255);


update nashvilehousing
set ownernewaddress =parsename(replace(owneraddress,',','.'),3)

alter table nashvilehousing
add ownercity nvarchar(255);

update nashvilehousing
set ownercity =parsename(replace(owneraddress,',','.'),2)

alter table nashvilehousing
add ownerstate nvarchar(255);

update nashvilehousing
set ownerstate=parsename(replace(owneraddress,',','.'),1)



select *  
from portfolioproject..nashvilehousing



select soldasvacant,count(soldasvacant)
from portfolioproject..nashvilehousing
group by soldasvacant
order by 2;


select soldasvacant,
case when soldasvacant= 'y' then 'yes'
     when soldasvacant= 'n' then 'no'
	 else soldasvacant
	 end
from portfolioproject..nashvilehousing
--group by soldasvacant
--order by 2;

update nashvilehousing
set soldasvacant=case when soldasvacant= 'y' then 'yes'
     when soldasvacant= 'n' then 'no'
	 else soldasvacant
	 end


select soldasvacant,count(soldasvacant)  
from portfolioproject..nashvilehousing
group by soldasvacant
order by 2



select *
from portfolioproject..nashvilehousing


with rownos as(
select *,
ROW_NUMBER() over(
 partition by parcelid,
              propertyaddress,
			  saleprice,
			  saledate,
			  legalreference
			  order by 
			  uniqueid) rowno

from portfolioproject..nashvilehousing
)

SELECT *
from rownos
--where rowno>1
order by propertyaddress

------------------------
SELECT * 
FROM portfolioproject..nashvilehousing

ALTER TABLE NASHVILEHOUSING
DROP COLUMN TAXDISTRICT,PROPERTYADDRESS;