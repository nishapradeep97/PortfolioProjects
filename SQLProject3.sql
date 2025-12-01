--Data Cleaning in SQL Query
Select *
from HousingData

--Standardize Date-Time  Format

ALTER TABLE HousingData
Add SaleDateConverted date

Update HousingData
SET SaleDateConverted=CONVERT(Date,SaleDate)

Select SaleDateConverted
from HousingData

--Populate property Address by using Self Join
Select *
from HousingData
--where PropertyAddress is null
Order by ParcelID

Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
from HousingData a
Join HousingData b
	on a.ParcelID=b.ParcelID
	and a.UniqueID<>b.UniqueID
--Where a.PropertyAddress is null

Update a
Set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from HousingData a
Join HousingData b
	on a.ParcelID=b.ParcelID
	and a.UniqueID<>b.UniqueID
Where a.PropertyAddress is null

-- Replaced all Null values 
Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
from HousingData a
Join HousingData b
	on a.ParcelID=b.ParcelID
	and a.UniqueID<>b.UniqueID


-- Splitting Address into Individual column(Address, City, Date) using Substring
Select PropertyAddress
from HousingData

Select
SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as Address
from HousingData

--+1 and -1 is added to avoid commas

ALTER TABLE HousingData
Add PropertySplitAddress Nvarchar(255);

Update HousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE HousingData
Add PropertySplitCity Nvarchar(255);

Update HousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
From HousingData


--Other way for splitting address Using Parse Name
Select OwnerAddress
From HousingData

Select
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From HousingData

--Adding columns and values

ALTER TABLE HousingData
Add OwnerSplitAddress Nvarchar(255);

Update HousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)


ALTER TABLE HousingData
Add OwnerSplitCity Nvarchar(255);

Update HousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE HousingData
Add OwnerSplitState Nvarchar(255);

Update HousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)


Select *
From HousingData

-- Yes or No to Sold as vacant
Select Distinct(SoldAsVacant), count(SoldAsVacant)
From HousingData
group by SoldAsVacant
Order by 2

Alter Table HousingData
Alter column SoldAsVacant NVarchar(50);

Select SoldAsVacant,
Case When SoldAsVacant=1 Then 'YES'
	When SoldAsVacant=0 Then 'NO'
	Else SoldAsVacant
	End
From HousingData

Update HousingData
SET SoldAsVacant= Case When SoldAsVacant=1 Then 'YES'
	When SoldAsVacant=0 Then 'NO'
	Else SoldAsVacant
	End
-- For Displaying

Select Distinct(SoldAsVacant), count(SoldAsVacant)
From HousingData
group by SoldAsVacant
Order by 2

----Removing Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From HousingData
)
--Deleting Duplicate 104 rows
--DELETE
--From RowNumCTE
--Where row_num > 1

Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

-- Delete unused columns

--Deleting Owneraddress, Taxdistrict and propertyAddress, Saledate

Select *
From HousingData

Alter Table HousingData
Drop column OwnerAddress, TaxDistrict,PropertyAddress
Alter Table HousingData
Drop column SaleDate

Select *
From HousingData





