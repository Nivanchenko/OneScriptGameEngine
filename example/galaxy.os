#Использовать "../"

Перем НаправлениеХ;
Перем НаправлениеУ;
Перем Игра;
Перем Персонаж;
Перем ФОН;
Перем УскорениеПерсонажа;

Процедура ИнициализироватьИгру()

	Игра = Новый Игра();

	Игра.ОтрисовкаВФоне = Ложь;
	Игра.ЗадержкаМеждуКадрами = 50;

	Игра.СкоростьИгровогоЦикла = 50;

	ОбработчикСобытийИнтерфейса = Новый Действие(ЭтотОбъект, "ОбработчикСобытийИнтерфейса");
	ОбработчикИгровогоЦикла = Новый Действие(ЭтотОбъект, "ОбработчикИгровогоЦикла");

	Игра.УстановитьОбработчикСобытийИнтерфейса(ОбработчикСобытийИнтерфейса);
	Игра.УстановитьОбработчикИгровогоЦикла(ОбработчикИгровогоЦикла);

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

	Игра.ДобавитьНастройкуНажатий(32,
								Новый Действие(ЭтотОбъект, "Персонаж_Стреляет"));

	ФОН = Игра.ДобавитьИгровойОбъект("ЗаднийФон", 0);
	ФОН.ОтображатьГраницы = Ложь;
	ФОН.Видимость = Ложь;
	ФОН.Высота = 500;
	ФОН.Ширина = 700;
	ФОН.КоординатаХ = 2;
	ФОН.КоординатаУ = 2;

	КартинкаКорабль = Игра.СоздатьАнимацию("example/SpaceShip.png");
	КартинкаКорабль.ДобавитьКадр("example/SpaceShip2.png");

	КартинкаФон = Игра.СоздатьАнимацию("example/background.png");

	Персонаж = Игра.ДобавитьИгровойОбъект("Игрок", 1);
	Персонаж.ОтображатьГраницы = Ложь;
	Персонаж.Видимость = Истина;
	Персонаж.Высота = 50;
	Персонаж.Ширина = 50;
	Персонаж.КоординатаХ = 200;
	Персонаж.КоординатаУ = 300;

	Персонаж.ДобавитьСобытие("Поздороваться", Новый Действие(ЭтотОбъект, "ДействиеПерсонажа"));
	Персонаж.УстановитьСвойство("Заряжен", Истина);

	Персонаж.УстановитьАнимацию(КартинкаКорабль);
	ФОН.УстановитьАнимацию(КартинкаФон);

	Кадр1 = Персонаж.ПолучитьКадр();
	Кадр2 = Персонаж.ПолучитьКадр();

	сорт = Игра.СортировкаСоотвествия(Игра.ИгровыеОбъекты, "СлойОтрисовки");

	//Игровая логика
	НаправлениеУ = 0;
	НаправлениеХ = 0;

	УскорениеПерсонажа = 10;

КонецПроцедуры

Процедура Персонаж_Стреляет() Экспорт
	Если Персонаж.ПолучитьСвойство("Заряжен") = Истина Тогда
		Сообщить("Пиф-паф");	
		Персонаж.УстановитьСвойство("Заряжен", Ложь);
		Игра.ДобавитьОтложенноеИгровоеСобытие(Новый Действие(ЭтотОбъект, "Персонаж_Перезарядить"),10);
	Иначе
		Сообщить("Перезарядка");
	КонецЕсли;
КонецПроцедуры

Процедура Персонаж_Перезарядить() Экспорт
	Персонаж.УстановитьСвойство("Заряжен", Истина);
	Сообщить("Орудие перезаряжено");	
КонецПроцедуры

Процедура ДействиеПерсонажа(ИгровойОбъект) Экспорт
	Сообщить("Привет я персонаж, мой тип " + ИгровойОбъект.ТипОбъекта);	
КонецПроцедуры

Процедура ОбработчикСобытийИнтерфейса(ИсточникСобытия, Событие) Экспорт
	//Сообщить(""+ ИсточникСобытия +" "+Событие);	
КонецПроцедуры

Процедура ОбработчикИгровогоЦикла() Экспорт
	Игра.ГлавноеОкно.Текст = Строка("Время "+ТекущаяДата());
	
	// Персонаж.ВыполнитьДействие("Поздороваться");
	
	//Движение персонажа
	Если НаправлениеХ = 0 И НаправлениеУ = 0 Тогда
		УскорениеПерсонажа = 10;
	Иначе
		Игра.ОбновитьКадр = Истина;
		УскорениеПерсонажа = Мин(УскорениеПерсонажа * 1.1, 30);
	КонецЕсли;
	Персонаж.КоординатаХ = Персонаж.КоординатаХ + (НаправлениеХ * УскорениеПерсонажа);
	Персонаж.КоординатаУ = Персонаж.КоординатаУ + (НаправлениеУ * УскорениеПерсонажа);
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
Игра.ЗапуститьПриложение("Galaxy OneScript");



