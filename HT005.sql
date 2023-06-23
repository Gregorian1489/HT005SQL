-- File: https://docs.google.com/spreadsheets/d/1bKCfz2tMENAISBxU7XRevge1qraNuPoN/edit?usp=share_link&ouid=112631188905352530754&rtpof=true&sd=true
-- Скрипт: https://drive.google.com/file/d/1rkNr6GHSE9ulRs39BB4RC80aKMg1c7Jw/view?usp=share_link

-- Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
CREATE VIEW cars_1 AS
SELECT * FROM Cars
WHERE cost < 25000;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW cars_1 AS
SELECT * FROM Cars
WHERE cost < 30000;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW skoda_and_audi
AS SELECT *
FROM AUTO
WHERE MARK='SKODA' OR MARK='AUDI';

/* Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение,
  мы вычитаем время станций для пар смежных станций. Мы можем вычислить это значение без использования оконной 
  функции SQL, но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD . 
  Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
  В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/  

SELECT train_id, station, station_time
SUBTIME(LEAD(station_time) OVER(PARTITION BY train_id ORDER BY train_id), station_time)
AS time_to_next_station
FROM Trains;
