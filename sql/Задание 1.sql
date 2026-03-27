--Задание 1.1:  Написать SQL запрос, который выведет код и наименование всех опций, стоимость которых более 900, в порядке возрастания цены.
select o.code, o.name
from option o
join option_price op on o.code = op.option_code
where op.price > 900
order by op.price;

--Задание 1.2:  Написать SQL запрос, который выведет количество клиентов, наименование которых начинается на ООО
select count(*) as client_count
from client
where name like 'ООО%';

--Задание 1.3: Написать SQL запрос, который выведет наименование и ИНН клиентов, у которых подключена опция «Маркетплейс»

select c.name, c.inn
from client c
join client_option co on c.inn = co.client_inn
join option o on co.option_code = o.code
where o.name = 'Маркетплейс';

--Задание 1.4:  Написать SQL запрос, который выведет наименование и ИНН клиентов в первой колонке с названием «Клиент (ИНН)» в формате: ООО «Росинка» (8394119283), во второй колонке с названием «Сумма за обслуживание» сумму, которую клиент платит за обслуживание тарифа (price из таблицы tariff), а также за все подключенные опции (price из таблицы option_price).

select 
    c.name || ' (' || c.inn || ')' as "Клиент (ИНН)",
    t.price + coalesce(sum(op.price), 0) as "Сумма за обслуживание"
from client c
join tariff t on c.tariff_code = t.code
left join client_option co on c.inn = co.client_inn
left join option_price op on co.option_code = op.option_code
group by c.inn, c.name, t.price;

--Задание 1.5:  Написать SQL запрос на добавление записи в таблицу client:
--Наименование: ООО «Крылатые качели»
--ИНН: 8823710320
--Тариф: Стартовый

insert into client (name, inn, tariff_code)
values ('ООО «Крылатые качели»', '8823710320', 'СТАРТОВЫЙ');