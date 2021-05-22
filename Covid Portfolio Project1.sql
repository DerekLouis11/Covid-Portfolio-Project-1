Select *
From [Portfolio Project]..CovidVaccinations$
where continent is not null
order by 3,4


Select *
From CovidDeaths$
order by 3,4

----Select the data We are going to be using
Select location,date,total_cases, new_cases, total_deaths, population
From CovidDeaths$
order by 1,2


-----Looking at total cases vs total deaths
-----Shows the likelihood of dying if you contract covid in your country
Select location,date,total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths$
order by 1,2

------Shows the likelihood of dying if you contract covid in your country
Select location,date,total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths$
where Location like '%states%'
order by 1,2

----Look at total cases vs population
----shows what percentage of public got covid
Select location,date, new_cases, population,total_cases,(total_cases/population)*100 as DeathPercentage
From CovidDeaths$
where Location like '%states%'
order by 1,2

Select location,date, new_cases, population,total_cases,(total_cases/population)*100 as percentpopulationinfected
From CovidDeaths$
where Location like '%united kingdom%'
order by 1,2

----- Looking at the country with the hgighest infection rate compared to population
Select location,population, MAX(total_cases) as highestinfectioncount, Max((total_cases/population))*100 as percentpopulationinfected
From CovidDeaths$
----where Location like '%states%'
where continent is not null
Group by location, Population 
order by percentpopulationinfected desc

------showing the country with the highest death count per population
Select location, MAX(cast(total_deaths as int)) as TotalDeathcount
From CovidDeaths$
----where Location like '%states%'
where continent is not null
Group by location, Population 
order by TotalDeathcount desc

---- Lets break things down by continent
Select continent, MAX(cast(total_deaths as int)) as TotalDeathcount
From CovidDeaths$
----where Location like '%states%'
where continent is not null
Group by continent
order by TotalDeathcount desc


---- Lets break things down by continent
Select location, MAX(cast(total_deaths as int)) as TotalDeathcount
From CovidDeaths$
----where Location like '%states%'
where continent is null
Group by location
order by TotalDeathcount desc


--- showing continents with the highest death count per population
Select continent, MAX(cast(total_deaths as int)) as TotalDeathcount
From CovidDeaths$
----where Location like '%states%'
where continent is not null
Group by continent
order by TotalDeathcount desc


------Global Numbers

Select location,date,total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths$
----where Location like '%states%'
where continent is not null
order by 1,2

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From CovidDeaths$
----where Location like '%states%'
where continent is not null
Group by date
order by 1,2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From CovidDeaths$
----where Location like '%states%'
where continent is not null
-----Group by date
order by 1,2


Select *
From [Portfolio Project]..CovidVaccinations$


Select *
From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date

-----Looking at Total Population vs Vaccination

Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
	  order by 2,3


	  Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
,	  SUM(cast(Vac.new_vaccinations as int)) OVER (partition by Dea.location)
From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
	  order by 2,3

	  Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
,	  SUM(CONVERT(int,Vac.new_vaccinations)) OVER (partition by Dea.location order by dea.location, dea.date)
From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
	  order by 2,3

----------Looking at Total Population vs Vaccinations

With PopVsVac (Continent,Location,Date,Population,New_Vaccination,RollingPeopleVaccinated)
as
(
	  	  Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
,	  SUM(CONVERT(int,Vac.new_vaccinations)) OVER (partition by Dea.location order by dea.location, 
   dea.date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
   	 From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
---order by 2,3
)
Select *
From  PopVsVac


 --- Use CTE

 With PopVsVac


 With PopVsVac (Continent,Location,Date,Population,New_Vaccination,RollingPeopleVaccinated)
as
(
	  	  Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
,	  SUM(CONVERT(int,Vac.new_vaccinations)) OVER (partition by Dea.location order by dea.location, 
   dea.date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
   	 From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
---order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100
From  PopVsVac


 --- Use CTE

 With PopVsVac



 ---TEMP TABLE

 Create Table  #PercentPopulationVaccinated
 (
 continent nvarchar(255),
 location  nvarchar(255),
 Date datetime,
 Population numeric,
 New_Vaccinations numeric,
 RollingPeopleVaccinated numeric
 )
  insert into #PercentPopulationVaccinated
 Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
,	  SUM(CONVERT(int,Vac.new_vaccinations)) OVER (partition by Dea.location order by dea.location, 
   dea.date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
   	 From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
---order by 2,3
Select *, (RollingPeopleVaccinated/population)*100
From  #PercentPopulationVaccinated


 ---TEMP TABLE


Drop Table if exists #PercentPopulationVaccinated
Create Table  #PercentPopulationVaccinated
 (
 continent nvarchar(255),
 location  nvarchar(255),
 Date datetime,
 Population numeric,
 New_Vaccinations numeric,
 RollingPeopleVaccinated numeric
 )
  insert into #PercentPopulationVaccinated
 Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
,	  SUM(CONVERT(int,Vac.new_vaccinations)) OVER (partition by Dea.location order by dea.location, 
   dea.date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
   	 From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
---order by 2,3
Select *, (RollingPeopleVaccinated/population)*100
From  #PercentPopulationVaccinated




-----Creating View to store data for later visualisations

create view PercentPopulationVaccinated as
Select Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations
, SUM(CONVERT(int,Vac.new_vaccinations)) OVER (partition by Dea.location order by dea.location, 
   dea.date) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
   	 From [Portfolio Project]..CovidDeaths$  Dea
Join [Portfolio Project]..CovidVaccinations$  Vac
      on dea.location = Vac.location
	  and Dea.date = Vac.date
	  where Dea.continent is not null
---order by 2,3

Select *
From  PercentPopulationVaccinated