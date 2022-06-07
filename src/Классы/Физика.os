Перем Игра;

&Желудь
&Характер("Компанейский")
Процедура ПриСозданииОбъекта(&Пластилин("Игра") _Игра)

	Игра = _Игра;

КонецПроцедуры

Функция СоздатьВектор(Х = 0, У = 0) Экспорт
	Возврат Новый Вектор(Х, У);	
КонецФункции

Функция ААВВСтолкновение(Объект1, Объект2) Экспорт
	
	Начало1 = Объект1.Позиция;
	Начало2 = Объект2.Позиция;

	Конец1 = Начало1.Скопировать().Прибавить(Новый Вектор(Объект1.Ширина, Объект1.Высота));
	Конец2 = Начало2.Скопировать().Прибавить(Новый Вектор(Объект2.Ширина, Объект2.Высота));

	Если (Конец1.Х < Начало2.Х or Начало1.Х > Конец2.Х) Тогда 
		Возврат Ложь;
	КонецЕсли;
		
	Если (Конец1.У < Начало2.У or Начало1.У > Конец2.У) Тогда 
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;

КонецФункции