
Перем Графика Экспорт;
Перем Интерфейс Экспорт;
Перем СкоростьИгровогоЦикла Экспорт;
Перем ИграРаботает Экспорт;
Перем ГлавноеОкно Экспорт;
Перем ИгровыеОбъекты Экспорт;
Перем ОбновитьКадр Экспорт;
Перем ОтрисовкаВФоне Экспорт;
Перем ЗадержкаМеждуКадрами Экспорт;
Перем ОбработчикСобытийИнтерфейса;
Перем ОбработчикИгровогоЦикла;
Перем ОбработчикиНажатий;
Перем ОтложеныеИгровыеСобытия;

Процедура ПриСозданииОбъекта()
	
    Графика = Новый Графика();

	Интерфейс = Графика.Интерфейс;

    СкоростьИгровогоЦикла = 500;
    ЗадержкаМеждуКадрами = 500;
    ОтрисовкаВФоне = Ложь;

    ОбработчикиНажатий = Новый Соответствие();  
    
    ИгровыеОбъекты = Новый Соответствие();

    ОбновитьКадр = Истина;

    ОтложеныеИгровыеСобытия = Новый ТаблицаЗначений();
    ОтложеныеИгровыеСобытия.Колонки.Добавить("СчетчикСобытий");
    ОтложеныеИгровыеСобытия.Колонки.Добавить("Делегат");
    ОтложеныеИгровыеСобытия.Колонки.Добавить("ВФоне");
    ОтложеныеИгровыеСобытия.Колонки.Добавить("ДопПараметры");

КонецПроцедуры

Функция СоздатьАнимацию(ПутьКФайлу = Неопределено, ЦветПрозрачности = Неопределено) Экспорт
    Анимация = Новый Анимация(Интерфейс);

    Если НЕ ПутьКФайлу = Неопределено Тогда
        Анимация.ДобавитьКадр(ПутьКФайлу, ЦветПрозрачности);
    КонецЕсли;

    Возврат Анимация;
    
КонецФункции

Функция Цвет(Красный, Зеленый, Синий) Экспорт
	Возврат Графика.Цвет(Красный, Зеленый, Синий);	
КонецФункции

Функция СортировкаСоотвествия(Соответствие, РеквизитСортировки) Экспорт
    СЗ = Новый СписокЗначений();
    Для Каждого КиЗ Из Соответствие Цикл
        СЗ.Добавить(КиЗ.Значение, КиЗ.Значение[РеквизитСортировки]);
    КонецЦикла;
    СЗ.СортироватьПоПредставлению();
    Возврат СЗ;
КонецФункции

Функция ДобавитьИгровойОбъект(_ТипОбъекта = "", _СлойОтрисовки = 0, _СлойФизики = 0) Экспорт

    НовыйИгровойОбъект = Новый ИгровойОбъект(_ТипОбъекта, _СлойОтрисовки, _СлойФизики);

    ИгровыеОбъекты.Вставить(НовыйИгровойОбъект.Идентификатор(), НовыйИгровойОбъект);
    
    Возврат НовыйИгровойОбъект;

КонецФункции

Процедура ДобавитьНастройкуНажатий(КодКнопки, ДействиеПриНажатии = Неопределено, ДействиеПриОсвобождении = Неопределено) Экспорт

    ОбработчикиНажатий.Вставить(КодКнопки, Новый Структура("КлавишаВниз, КлавишаВверх", ДействиеПриНажатии, ДействиеПриОсвобождении));
    
КонецПроцедуры

Процедура ДобавитьОтложенноеИгровоеСобытие(Делегат, ЗадержкаВИгровыхЦиклах = 0, ДопПараметры = Неопределено, ВФоне = Ложь) Экспорт
    НовоеСобытие = ОтложеныеИгровыеСобытия.Добавить();
    НовоеСобытие.Делегат = Делегат;
    НовоеСобытие.СчетчикСобытий = ЗадержкаВИгровыхЦиклах; 
    НовоеСобытие.ДопПараметры = ДопПараметры;
    НовоеСобытие.ВФоне = ВФоне; 
КонецПроцедуры

Процедура ОбработатьОтложенныеИгровыеСобытия()
    ОтработанныеСобытия = Новый Массив;
    Для каждого ТекСобытие Из ОтложеныеИгровыеСобытия Цикл
        Если ТекСобытие.СчетчикСобытий < 1 Тогда
            ТекСобытие.Делегат.Выполнить();
            ОтработанныеСобытия.Добавить(ТекСобытие);
        Иначе
            ТекСобытие.СчетчикСобытий = ТекСобытие.СчетчикСобытий - 1;    
        КонецЕсли;    
    КонецЦикла;

    Для каждого СобытиеУдалить Из ОтработанныеСобытия Цикл
        ОтложеныеИгровыеСобытия.Удалить(СобытиеУдалить);
    КонецЦикла;
КонецПроцедуры

Процедура УстановитьОбработчикСобытийИнтерфейса(Делегат) Экспорт

    ОбработчикСобытийИнтерфейса = Делегат;
    
КонецПроцедуры

Процедура УстановитьОбработчикИгровогоЦикла(Делегат) Экспорт

    ОбработчикИгровогоЦикла = Делегат;
    
КонецПроцедуры

Процедура ИгровойЦикл() Экспорт

    Пока ИграРаботает Цикл
        ОбработатьОтложенныеИгровыеСобытия();
        Если не ОбработчикИгровогоЦикла = Неопределено Тогда 
            ОбработчикИгровогоЦикла.Выполнить();
        КонецЕсли;
        Если ОбновитьКадр и не ОтрисовкаВФоне Тогда
            Графика.ОтрисоватьЭкран(СортировкаСоотвествия(ИгровыеОбъекты, "СлойОтрисовки"));
        КонецЕсли;
        Приостановить(СкоростьИгровогоЦикла);
    КонецЦикла
    
КонецПроцедуры

Процедура ФоноваяОтрисовка() Экспорт
    Пока ОтрисовкаВФоне = Истина Цикл
        Если ОбновитьКадр Тогда
            Графика.ОтрисоватьЭкран(СортировкаСоотвествия(ИгровыеОбъекты, "СлойОтрисовки"));
        КонецЕсли;
        Если ЗадержкаМеждуКадрами > 0 Тогда
            Приостановить(ЗадержкаМеждуКадрами);
        КонецЕсли;
    КонецЦикла;
КонецПроцедуры

Процедура ЗапуститьВФоне(Делегат, ДопПараметры = Неопределено, Ждать = 0) Экспорт
    Параметры = Новый Массив;
    Параметры.Добавить(Делегат);
    Параметры.Добавить(ДопПараметры);
    Параметры.Добавить(Ждать);
    ФоновыеЗадания.Выполнить(ЭтотОбъект, "ФоновыйЗапускДелегата", Параметры)
КонецПроцедуры

Процедура ФоновыйЗапускДелегата(Делегат, ДопПараметры = Неопределено, Ждать = 0) Экспорт

    Если Ждать > 0  Тогда
        Приостановить(Ждать);
    КонецЕсли;

    Если ДопПараметры = Неопределено Тогда
        Делегат.Выполнить();    
    Иначе
        Делегат.Выполнить(ДопПараметры);
    КонецЕсли;

КонецПроцедуры

Процедура ОстановитьИгровойЦикл() Экспорт
    ИграРаботает = Ложь;    
КонецПроцедуры

Процедура ЗапуститьОбработчикВвода() Экспорт

    ГлавноеОкно.КлавишаВниз = "КлавишаВниз";
    ГлавноеОкно.КлавишаВверх = "КлавишаВверх";

    Пока Интерфейс.Продолжать Цикл
        Событие = СтрЗаменить(Интерфейс.ПолучитьСобытие(), "()","");
        Отправитель = Интерфейс.Отправитель;
        Если Событие = "КлавишаВниз" ИЛИ Событие = "КлавишаВверх" Тогда 
            Клавиша = Интерфейс.КлавишаАрг();
            СобытияКнопки = ОбработчикиНажатий[Клавиша.КодКлавиши];
            Если НЕ СобытияКнопки = Неопределено Тогда
                ДелегатСобытия = СобытияКнопки[Событие];
                Если не ДелегатСобытия = Неопределено Тогда
                    ДелегатСобытия.Выполнить();
                КонецЕсли;
            КонецЕсли;
        ИначеЕсли не ОбработчикСобытийИнтерфейса = Неопределено Тогда
            ОбработчикСобытийИнтерфейса.Выполнить(Отправитель, Событие);
        КонецЕсли
    КонецЦикла;

КонецПроцедуры

Процедура ЗапуститьПриложение(Заголовок = "", ШиринаОкна = 800, ВысотаОкна = 600) Экспорт
    
    ИграРаботает = Истина;

    ГлавноеОкно = Графика.ГлавноеОкно();

    ЗапуститьВФоне(Новый Действие(ЭтотОбъект, "ИгровойЦикл"));
    Если ОтрисовкаВФоне Тогда
        ЗапуститьВФоне(Новый Действие(ЭтотОбъект, "ФоноваяОтрисовка"));    
    КонецЕсли;
    ЗапуститьОбработчикВвода();
    
КонецПроцедуры
