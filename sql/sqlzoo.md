## SELECT basics

SELECT population FROM world WHERE name = 'France';

SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway', 'Denmark');


SELECT name, area FROM world WHERE area BETWEEN 200000 AND 250000;


##### SELECT from WORLD Tutorial
1
```sql
SELECT name, continent, population FROM world
```
2
```sql
SELECT name FROM world
WHERE population >= 200000000
```
3
```sql
SELECT name, gdp/population AS pcGDP FROM world 
WHERE population >= 200000000;
```

4
```sql
SELECT name, population/1000000 mp FROM world
WHERE continent = 'South America';
```

5

```sql
SELECT name, population FROM world
WHERE name IN ('France', 'Germany', 'Italy')
```


6

```sql
SELECT name FROM world
WHERE name LIKE '%United%';
```

7
```sql
SELECT name, population, area FROM world
WHERE area > 3000000 OR population > 250000000;
```

8

```sql
SELECT name, population, area FROM world
WHERE area > 3000000 AND population <= 250000000 OR area <= 3000000 AND population > 250000000;
```

9
```sql
SELECT name, ROUND(population/1000000,2) population, ROUND(GDP/1000000000,2) gdp FROM world
WHERE continent = 'South America'
```
10

```sql
SELECT name, ROUND(GDP/population/1000)*1000 FROM world
WHERE GDP >= 1000000000000;
```

```sql
SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital);
```

```sql
SELECT name, capital FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name != capital;
```

```sql
SELECT name
FROM world
WHERE name LIKE '%a%' AND
      name LIKE '%e%' AND
      name LIKE '%i%' AND
      name LIKE '%o%' AND
      name LIKE '%u%' AND
      name NOT  LIKE '% %' 

SELECT name FROM world 
WHERE name IN (SELECT name FROM world 
WHERE name IN (SELECT name FROM world 
WHERE name IN (SELECT name FROM world
WHERE name IN (SELECT name FROM world
WHERE name IN ( SELECT name FROM world
WHERE name NOT LIKE  '% %')
AND name LIKE '%a%')
AND name LIKE '%e%')
AND name LIKE '%i%')
AND name LIKE '%o%')
AND name LIKE '%u%';
```


#### SELECT from Nobel Tutorial

```sql
SELECT winner FROM nobel
WHERE subject = 'Peace' AND yr >= 2000;
```
```sql
SELECT  * FROM nobel
WHERE subject = 'Literature' AND yr >= 1980 AND yr <= 1989;
```

```sql
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

```

```sql
SELECT winner FROM nobel
WHERE winner LIKE 'John %'
```

```sql
SELECT * FROM nobel
WHERE subject = 'Physics' AND yr = '1980' OR subject = 'Chemistry' AND yr = '1984' 

```

```sql
SELECT * FROM nobel
WHERE winner = 'EUGENE O\'NEILL'
```

```sql
SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner;

```

```sql
select winner, subject
from nobel
where yr=1984
order by subject in ('Physics','Chemistry'),subject,winner
```

### SELECT within SELECT Tutorial

```sql
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
```

```sql
SELECT name FROM world
WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')
```

```sql
SELECT name, continent FROM world
WHERE continent IN (SELECT continent FROM world WHERE name = 'Argentina' OR name = 'Australia') ORDER BY name
```

```sql
SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND
population < (SELECT population FROM world WHERE name = 'Poland')
```

```sql
SELECT name, CONCAT(ROUND(population/(select population from world where name = 'Germany') * 100), '%') AS percenteage FROM world WHERE continent = 'Europe';
```

```sql
SELECT name FROM world
WHERE gdp > (select max(gdp) from world where continent = 'Europe')
```

```sql
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE x.continent = y.continent)
```
```sql
select continent,name
from world x
where x.name<=all(select name from world y where x.continent=y.continent)
```

```sql
select name,continent
from world as x
where population/3>=all(select population from world y where x.continent=y.continent  and x.name!=y.name)
 ```


### SUM and COUNT


```sql
select continent, COUNT(name) from world
group by continent
 ```

 ```sql
select continent, COUNT(name) from world
where population >= 10000000
group by continent
 ```
```sql
 select continent from world
  group by continent
  having SUM(population) >= 100000000
```

### The JOIN operation

