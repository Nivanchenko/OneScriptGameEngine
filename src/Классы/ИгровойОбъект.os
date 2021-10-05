Перем ТипОбъекта Экспорт;
Перем Высота Экспорт;
Перем Ширина Экспорт;
Перем КоординатаХ Экспорт;
Перем КоординатаУ Экспорт;
Перем ЭтоИгрок Экспорт;
Перем Свойства Экспорт;
Перем Действия Экспорт;
Перем СлойОтрисовки Экспорт;
Перем СлойФизики Экспорт;
Перем ОтображатьГраницы Экспорт;
Перем ТолщинаГраницы Экспорт;
Перем Видимость Экспорт;
Перем Идентификатор;

Процедура ПриСозданииОбъекта(_ТипОбъекта = "", _СлойОтрисовки = 0, _СлойФизики = 0)

	ОтображатьГраницы = Ложь;
	ТолщинаГраницы = 2;
	Видимость = Ложь;

	ТипОбъекта = _ТипОбъекта;
	СлойФизики = _СлойФизики;
	СлойОтрисовки = _СлойОтрисовки;

	Свойства = Новый Соответствие();
	Действия = Новый Соответствие();

	Идентификатор = Строка(Новый УникальныйИдентификатор());
	
КонецПроцедуры

Процедура ДобавитьСобытие(ИмяДействия, Действие) Экспорт

	Действия.Вставить(ИмяДействия, Действие);
	
КонецПроцедуры

Процедура ВыполнитьДействие(ИмяДействия) Экспорт
	ИскомоеДействие = Действия[ИмяДействия];
	Если ИскомоеДействие = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Действие %1 не определено", ИмяДействия);
	Иначе
		ИскомоеДействие.Выполнить(ЭтотОбъект);
	КонецЕсли;
КонецПроцедуры

Функция Идентификатор() Экспорт
	Возврат Идентификатор;
КонецФункции