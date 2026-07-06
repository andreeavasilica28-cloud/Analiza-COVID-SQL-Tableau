select *
from CovidDeaths
where continent is not null
ORDER BY location, date;

select *
from CovidVaccination
ORDER BY 3,4

SELECT CovidDeaths.location, DATE, CovidDeaths.total_cases, CovidDeaths.new_cases, CovidDeaths.total_deaths, CovidDeaths.population
FROM CovidDeaths
ORDER BY location, date

--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS FLOAT) / total_cases) * 100 AS DeathPercentage
FROM CovidDeaths
where location like '%states%'
order by location, date;


--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

SELECT
    location,
    date,
    population,
    (CAST(total_cases AS FLOAT) / population) * 100 AS DeathPercentage
FROM CovidDeaths
where location like '%romania%'
order by location, date;

--Looking at Countries with Highest Infection Rate compared to Population


SELECT
    location,
    population,
    MAX(CAST(total_cases AS FLOAT)) AS Highest_Infection_Count,
    MAX((CAST(total_cases AS FLOAT) / population)) * 100 AS Percent_Population_Infected
FROM CovidDeaths
GROUP BY location, population
ORDER BY Percent_Population_Infected DESC;

--Showing Countries with Highest Death Count per Population

Select location,
      max(cast(total_deaths as int))  as Total_Death_Count
from CovidDeaths
--where continent is not null
group by location, continent
order by Total_Death_Count desc;

--LET'S BREAK THINGS DOWN BY CONTINENT

Select location,
      max(cast(total_deaths as int))  as Total_Death_Count
from CovidDeaths
where continent IS NOT null
group by location
order by Total_Death_Count desc;

--Showing continents with the highest death count per population

Select continent,
      max(cast(total_deaths as int))  as Total_Death_Count
from CovidDeaths
where continent IS NOT null
group by continent
order by Total_Death_Count desc;

--Global Numbers

SELECT date,
    sum(new_cases) as total_cases,
    sum(cast(new_deaths as int)),sum(cast(new_deaths as int))/sum(CovidDeaths.new_cases)*100 as Death_Procentage
FROM CovidDeaths
WHERE continent IS NOT NULL
Group By  date
ORDER BY 1,2;


--Loking as TOTAL POPULATION vs VACCINATION

SELECT
    dea.continent,
    dea.location,
    dea.date_fixed,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location
        ORDER BY dea.date_fixed
    ) AS Rolling_people_Vaccinated,
FROM CovidDeaths_Fixed dea
JOIN CovidVaccination_Fixed vac
    ON dea.location = vac.location
    AND dea.date_fixed = vac.date_fixed
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;

--Temp Table

create TABLE if not exists Percent_Population_Vaccinated
(continent varchar(255),
location  varchar (255),
date datetime,
population  numeric,
New_vaccination numeric,
Rolling_People_vaccinated numeric);

insert into Percent_Population_Vaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       sum(vac."new_vaccinations") over (partition by dea.location order by dea.location, dea.date)
as Rolling_people_Vaccinated
from CovidDeaths dea
join CovidVaccination vac
on dea.location=vac.location
and dea.date=vac.date;

select *, (Percent_Population_Vaccinated.Rolling_People_vaccinated/population)*100
from Percent_Population_Vaccinated;

--Creating View to store data for later Visualization

drop view  Percent_Population_Vaccinated;

CREATE VIEW Percent_Population_Vaccinated AS
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS REAL)) OVER (
        PARTITION BY dea.location
        ORDER BY dea.location, dea.date
    ) AS Rolling_people_Vaccinated
FROM CovidDeaths dea
JOIN CovidVaccination vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

select *
from Percent_Population_Vaccinated;







