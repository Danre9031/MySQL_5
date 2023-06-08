use dz05;

/*
1.Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов;
*/
CREATE VIEW auto_25_more AS
	SELECT *
    FROM cars
    WHERE cost <= 25000;
SELECT * FROM auto_25_more;



/*
2.Изменить в существующем представлении порог для стоимости: пусть цена будет 
до 30 000 долларов (используя оператор ALTER VIEW);
*/
ALTER VIEW auto_25_more AS
	SELECT *
    FROM cars
    WHERE cost <= 30000;
SELECT * FROM auto_25_more;
/*
3.Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)
*/
-- DROP VIEW  autoSkAu;

CREATE VIEW autoSkAu AS
	SELECT *
    FROM cars
    WHERE name = 'Audi' OR name ='Skoda';

SELECT * FROM autoSkAu;

/*
4.Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, 
мы вычитаем время станций для пар смежных станций. Мы можем вычислить это значение без использования 
оконной функции SQL, но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD . 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/
SELECT
  train_id,
  station,
  station_time
  SUBTIME(
    LEAD(station_time) 
	OVER(PARTITION BY train_id 
	  ORDER BY station_time), station_time) 
  AS 'Время до следующей станции'
FROM trains;