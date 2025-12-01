
Select *
From CovidDeaths
order by 3,4

Select *
From CovidVaccinations
order by 3,4
--select data to be used

Select location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
order by 1,2

--Looking at total cases vs total death
Select location, date, total_cases, total_deaths,(total_deaths/total_cases) * 100 as DeathPercentage
From CovidDeaths
order by 1,2

--Total cases vs Population
Select location, date, total_cases, population,(total_cases/population)*100 as DeathPercentage
From CovidDeaths
--Where location like '%India%'
order by 1,2

 --Countries with Highest infection rate compared to population
Select location,population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as PercentagePopulationInfected
From CovidDeaths
--Where location like '%India%'
Group by location,population
Order by PercentagePopulationInfected Desc

--Countries with Highest death counts per Population
Select location,MAX(total_deaths) as TotalDeathCount
From CovidDeaths
--Where location like '%India%'
Where continent is not null
Group by location
Order by TotalDeathCount Desc

--Sort things in case of continents
--Continents with Highest death count per population
Select continent,MAX(total_deaths) as TotalDeathCount
From CovidDeaths
--Where location like '%India%'
Where continent is not null
Group by continent
Order by TotalDeathCount Desc

--Global Numbers
Select SUM(new_cases)as TotalCases,SUM(new_deaths) as TotalDeaths, SUM(cast(new_deaths as float))/SUM(cast(new_cases as float))*100 as DeathPercentage
From CovidDeaths
Where continent is not null
Group by Date
order by 1,2


--Covid Vaccination table
--Total population vs Vaccinations
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
From CovidDeaths as dea
Join CovidVaccinations as vac
on dea.location=vac.location
and dea.date=vac.date
Where dea.continent is not null
order by 2,3

--Use CTE
With PopvsVac (Continent, location, date, population,new_vaccinations, Rollingpeoplevaccinated)
as
(Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
From CovidDeaths as dea
Join CovidVaccinations as vac
on dea.location=vac.location
and dea.date=vac.date
Where dea.continent is not null
--order by 2,3
)
select *,(Rollingpeoplevaccinated/population)*100
From PopvsVac

-- Creating a temperory table
Drop Table if exists  #Percenpopulationvaccinated
Create Table #Percenpopulationvaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric, 
RollingPeopleVaccinated numeric
)
Insert into #Percenpopulationvaccinated
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
From CovidDeaths as dea
Join CovidVaccinations as vac
on dea.location=vac.location
and dea.date=vac.date
Where dea.continent is not null
--order by 2,3
select *,(Rollingpeoplevaccinated/population)*100
From #Percenpopulationvaccinated

--Creating View to store data for later visualisation
Create View Percenpopulationvaccinated as 
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location,dea.date) as Rollingpeoplevaccinated
From CovidDeaths as dea
Join CovidVaccinations as vac
on dea.location=vac.location
and dea.date=vac.date
Where dea.continent is not null
--order by 2,3

Select * 
From Percenpopulationvaccinated
