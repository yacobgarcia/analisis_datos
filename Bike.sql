--- Obtiene el total de usuario por mes de cada año
select YEAR(started_at), MONTH(started_at), count(ride_id) from [tripdata_2022]
group by YEAR(started_at), MONTH(started_at)
UNION
select YEAR(started_at), MONTH(started_at), count(ride_id) from [tripdata_2021]
group by YEAR(started_at), MONTH(started_at)



--- Obtener los datos con tiempos de duración
SELECT [ride_id]
      ,[rideable_type]
      ,[started_at]
      ,[ended_at]
      ,[start_station_name]
      ,[end_station_name]
      ,[member_casual]
	  ,DATEDIFF(MINUTE, started_at, ended_at) minutos
	  ,Convert(varchar(2),  (DATEDIFF(MINUTE, started_at, ended_at)  / 60 ) % 60) + ':' +	
	  case when len( convert(varchar(2),  (DATEDIFF(MINUTE, started_at, ended_at) ) % 60)) = 1 then
	  '0' +  convert(varchar(2),  (DATEDIFF(MINUTE, started_at, ended_at) ) % 60)
	  else
	  convert(varchar(2),  (DATEDIFF(MINUTE, started_at, ended_at) ) % 60)
	  end Tiempo,
	  datepart(DW, started_at) diaSemana

  FROM [Cyclistic].[dbo].[tripdata_2022]
 order by started_at, start_station_name
  

--- Obtener los datos basicos para el analisis
SELECT top 100 rideable_type, started_at, start_station_name, member_casual, 
  DATEDIFF(MINUTE, started_at, ended_at) minutos,
   datepart(DW, started_at) diaSemana,
   convert(date, started_at) fecha
from [tripdata_2022]




-- -Datos de usuarios por tipo de Bicicleta, feha, estacion de inicio, tipo usuario, minutos y usuarios
SELECT rideable_type, convert(date, started_at), start_station_name, member_casual, sum( DATEDIFF(MINUTE, started_at, ended_at)) Minutos, count(ride_id) Usuarios
from [tripdata_2022]
group by rideable_type, convert(date, started_at), start_station_name, member_casual


--- TOP DE ESTACIONES con mas usuarios

SELECT month(started_at) Mes, start_station_name, member_casual, sum( DATEDIFF(MINUTE, started_at, ended_at)) Minutos, count(ride_id) Usuarios, datepart(DW, started_at) diaSemana
from [tripdata_2022]
group by month(started_at), start_station_name, member_casual, datepart(DW, started_at) 
having start_station_name <> '' and member_casual = 'casual'
order by count(ride_id) DESC



