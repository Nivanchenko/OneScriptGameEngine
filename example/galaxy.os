#Использовать "../"

Перем НаправлениеХ;
Перем НаправлениеУ;
Перем Игра;
Перем Персонаж;
Перем ФОН;
Перем УскорениеПерсонажа;
Перем ПулиПерсонажа;
Перем ЦВЕТ_БЕЛЫЙ;
Перем Анимация_Пуля;
Перем Физика;

Процедура ИнициализироватьИгру()

	// Основные объекты
	Игра = ОдноДвиж.СоздатьИгру();

	Игра.ОтрисовкаВФоне = Ложь;
	
	Игра.СкоростьИгровогоЦикла = 50;

	ОбработчикСобытийИнтерфейса = Новый Действие(ЭтотОбъект, "ОбработчикСобытийИнтерфейса");
	ОбработчикИгровогоЦикла = Новый Действие(ЭтотОбъект, "ОбработчикИгровогоЦикла");

	Игра.УстановитьОбработчикСобытийИнтерфейса(ОбработчикСобытийИнтерфейса);
	Игра.УстановитьОбработчикИгровогоЦикла(ОбработчикИгровогоЦикла);

	// Управление

	Игра.ДобавитьНастройкуНажатий(37,
								Новый Действие(ЭтотОбъект, "ДвижениеВлево"),
								Новый Действие(ЭтотОбъект, "СтопХ"));

	Игра.ДобавитьНастройкуНажатий(39,
								Новый Действие(ЭтотОбъект, "ДвижениеВправо"),
								Новый Действие(ЭтотОбъект, "СтопХ"));
	
	Игра.ДобавитьНастройкуНажатий(38,
								Новый Действие(ЭтотОбъект, "ДвижениеВверх"),
								Новый Действие(ЭтотОбъект, "СтопУ"));

	Игра.ДобавитьНастройкуНажатий(40,
								Новый Действие(ЭтотОбъект, "ДвижениеВниз"),
								Новый Действие(ЭтотОбъект, "СтопУ"));

	Игра.ДобавитьНастройкуНажатий(231,
								Новый Действие(ЭтотОбъект, "Персонаж_Стреляет"));

	// Анимации

	ЦВЕТ_БЕЛЫЙ = Игра.Цвет(255,255,255);

	КартинкаКорабль = Игра.СоздатьАнимацию("example/SpaceShip.png", ЦВЕТ_БЕЛЫЙ);
	КартинкаКорабль.ДобавитьКадр("example/SpaceShip2.png", ЦВЕТ_БЕЛЫЙ);

	Анимация_Пуля = Игра.СоздатьАнимацию("example/bullet.png", ЦВЕТ_БЕЛЫЙ);

	КартинкаФон = Игра.СоздатьАнимацию("example/background.png");

	// Игровые объекты

	ФОН = СоздатьФон(КартинкаФон); 

	Персонаж = СозданиеПерсонажа(КартинкаКорабль);

	// Физика
	Физика = Игра.СоздатьФизику();


	//Игровая логика
	НаправлениеУ = 0;
	НаправлениеХ = 0;
	УскорениеПерсонажа = 10;
	ПулиПерсонажа = Новый Массив();

	// Отладка
	

КонецПроцедуры

Функция СоздатьФон(КартинкаФон)
	ИгрвойОбъект = Игра.ДобавитьИгровойОбъект("ЗаднийФон", 0);
	ИгрвойОбъект.ОтображатьГраницы = Ложь;
	ИгрвойОбъект.Видимость = Истина;
	ИгрвойОбъект.Высота = 500;
	ИгрвойОбъект.Ширина = 700;
	ИгрвойОбъект.Позиция.Х = 2;
	ИгрвойОбъект.Позиция.У = 2;
	ИгрвойОбъект.УстановитьАнимацию(КартинкаФон);
	
	Возврат ИгрвойОбъект;
КонецФункции

Функция СозданиеПерсонажа(КартинкаКорабль)
	ИгрвойОбъект = Игра.ДобавитьИгровойОбъект("Игрок", 1);
	ИгрвойОбъект.ОтображатьГраницы = Ложь;
	ИгрвойОбъект.Видимость = Истина;
	ИгрвойОбъект.Высота = 50;
	ИгрвойОбъект.Ширина = 50;
	ИгрвойОбъект.Позиция.Х = 200;
	ИгрвойОбъект.Позиция.У = 300;
	ИгрвойОбъект.УстановитьСвойство("Заряжен", Истина);
	ИгрвойОбъект.УстановитьАнимацию(КартинкаКорабль, 5);	

	Возврат ИгрвойОбъект;
КонецФункции

Процедура Персонаж_ВыпуститьПулю() Экспорт;
	Пуля = СоздатьПулю();
	Пуля.Видимость = Истина;
	Пуля.Позиция.Х = Персонаж.Позиция.Х - 5 + Персонаж.Ширина / 2;
	Пуля.Позиция.У = Персонаж.Позиция.У - Пуля.Высота;

	Пуля.УстановитьАнимацию(Анимация_Пуля);
	Пуля.ДобавитьСобытие("Пуля_Лететь", Новый Действие(ЭтотОбъект, "Пуля_Лететь"));

	ПулиПерсонажа.Добавить(Пуля);

	Игра.ПодписатьНаИгровойЦикл(Пуля, Новый Действие(Пуля, "ВыполнитьДействие"), "Пуля_Лететь");
	Игра.ДобавитьОтложенноеИгровоеСобытие(Новый Действие(ЭтотОбъект, "Пуля_Удалить"),50, Пуля);
	
КонецПроцедуры

Процедура Персонаж_Стреляет() Экспорт
	Сообщить("пиу");
	// Если Персонаж.ПолучитьСвойство("Заряжен") = Истина Тогда	
	// 	Персонаж_ВыпуститьПулю();
	// 	Персонаж.УстановитьСвойство("Заряжен", Ложь);
	// 	Игра.ДобавитьОтложенноеИгровоеСобытие(Новый Действие(ЭтотОбъект, "Персонаж_Перезарядить"),10);
	// КонецЕсли;
КонецПроцедуры

Процедура Персонаж_Перезарядить() Экспорт
	Персонаж.УстановитьСвойство("Заряжен", Истина);	
КонецПроцедуры

Функция СоздатьПулю()
	ИгрвойОбъект = Игра.ДобавитьИгровойОбъект("Пуля", 2);
	ИгрвойОбъект.ОтображатьГраницы = Ложь;
	ИгрвойОбъект.Видимость = Ложь;
	ИгрвойОбъект.Высота = 17;
	ИгрвойОбъект.Ширина = 7;
	
	Возврат ИгрвойОбъект;
КонецФункции

Процедура Пуля_Удалить(ЭтаПуля) Экспорт
	ПулиПерсонажа.Удалить(ПулиПерсонажа.Найти(ЭтаПуля));
	ЭтаПуля.УдалитьОтложено();	
КонецПроцедуры

Процедура Пуля_Лететь(ЭтаПуля) Экспорт
	СкоростьПули = 6;
	ЭтаПуля.Позиция.У = ЭтаПуля.Позиция.У - СкоростьПули;	
	Сообщить("Расстояние: " + Физика.РасстояниеМеждуТочек(ЭтаПуля.Позиция.Х, ЭтаПуля.Позиция.У, Персонаж.Позиция.Х, Персонаж.Позиция.У));
КонецПроцедуры

Процедура ОбработчикСобытийИнтерфейса(ИсточникСобытия, Событие) Экспорт
	//Сообщить(""+ ИсточникСобытия +" "+Событие);	
КонецПроцедуры

Процедура ОбработчикИгровогоЦикла() Экспорт
	Игра.ГлавноеОкно.Текст = Строка("Время "+ТекущаяДата());

	// Для Каждого ТекПуля из ПулиПерсонажа Цикл
	// 	ТекПуля.ВыполнитьДействие("Пуля_Лететь");
	// КонецЦикла;
	
	// Персонаж.ВыполнитьДействие("Поздороваться");
	
	//Движение персонажа
	Если НаправлениеХ = 0 И НаправлениеУ = 0 Тогда
		УскорениеПерсонажа = 10;
	Иначе
		УскорениеПерсонажа = Мин(УскорениеПерсонажа * 1.1, 30);
	КонецЕсли;
	Персонаж.Позиция.Х = Персонаж.Позиция.Х + (НаправлениеХ * УскорениеПерсонажа);
	Персонаж.Позиция.У = Персонаж.Позиция.У + (НаправлениеУ * УскорениеПерсонажа);
	//--

КонецПроцедуры

Процедура СтопХ() Экспорт
	НаправлениеХ = 0;
КонецПроцедуры

Процедура СтопУ() Экспорт
	НаправлениеУ = 0;
КонецПроцедуры

Процедура ДвижениеВлево() Экспорт
	НаправлениеХ = -1;
КонецПроцедуры

Процедура ДвижениеВправо() Экспорт
	НаправлениеХ = 1;
КонецПроцедуры

Процедура ДвижениеВверх() Экспорт
	НаправлениеУ = -1;
КонецПроцедуры

Процедура ДвижениеВниз() Экспорт
	НаправлениеУ = 1;
КонецПроцедуры

ИнициализироватьИгру();
Игра.ЗапуститьПриложение("Galaxy OneScript", 700, 500);



