Пичугин Александр Дмитриевич
<br /> Когорта: 6
<br /> Группа: 4
<br /> Эпик: Статистика 
<br /> Ссылка на доску: https://github.com/users/artwist-polyakov/projects/1/views/1

# Statistic Flow Decomposition


## Экран Statistics (est 10 hr; fact 9.6 hr).

#### Верстка
- создание кнопки сортировки (est: 15 min; fact: 15 min).
- создание ячейки таблицы (est: 120 min ; fact: 150 min). 
- создание таблицы (est: 60 min; fact: 60 min).
- создание окна выбора типа фильтрации (est: 15 min; fact: 20 min).

`Total:` est: 210 min; fact: 245 min.

#### Логика
- переход на экран User Cart (est: 15 min; fact: 20 min).
- логика сетевого слоя для загрузки в таблицу аватарки, имени пользователя, кол-ва NFT (est: 180 min; fact: 240 min).
- индикатор загрузки (est: 30 min; fact: 30 min).
- сортировка (est: 60 min; fact: 30 min).
- сохранить способ сортировки (est: 60 min; fact: 15 min).

`Total:` est: 345 min; fact: 335 min.

## Экран User Card (est 5 hr; fact 4.8 hr).

#### Верстка

 - фото пользователя (est: 15 min; fact: 15 min).
 - имя пользователя (est: 15 min; fact: 15 min).
 - описание пользователя (est: 15 min; fact: 15 min).
 - кнопка "Перейти на сайт пользователя" (est: 15 min; fact: 15 min).
 - кнопка коллекция NFT (est: 15 min; fact: 15 min).

`Total:` est: 75 min; fact: 75 min).

#### Логика
- переход на сайт пользователя c созданием WebView (est: 180 min; fact: 180 min).
- переход на экран Users Collection (est: 15 min; fact: 30 min).

`Total:` est: 195 min; fact: 210 min.


## Экран Users Collection (est 11 hr; fact 16.4 hr).

#### Верстка
- верстка навбара (est: 15 min; fact: 15 min).
- верстка ячейчки UICollectionView с иконкой, сердечком, названием, рейтингом из 0-5 звезд, стоимостью NFT (в ETH), кнопкой добавления/удаления NFT из корзины.(est: 210 min; fact: 210 min).
- создание  UICollectionView(est: 60 min; fact: 60 min).

`Total:` est: 285 min; fact: 285 min.

#### Логика

- логика сетевого слоя для загрузки данных для UICollectionView (est: 180 min; fact: 180 min).
- логика сетевого слоя для удаления/добавления NFT из корзины (est: 180 min; fact: 300 min).
- индикатор загрузки (est: 30 min; fact: 10 min).


`Total:` est: 360 min; fact: 490 min.
