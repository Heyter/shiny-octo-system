--[[---------------------------------------------------------------------------
Файл русского языка
---------------------------------------------------------------------------
Не трогайте фразы находящиеся слева от знака равенства, для перевода какой-то фразы нужно заменить текст находящийся в кавычках справа от знака равенства.
Так же нельзя удалять следующее:
1. %s - выступает подстановкой фраз;
2. %d - выступает подстановкой чисел;
3. %s%d - выступает подстановкой фраз и чисел.

Перевод предоставлен сайтом www.GMod-Fan.ru. Перевод распространяется на бесплатной основе.
Не присваивайте перевод себе.
В противном случае администрации www.GMod-Fan.ru придется ввести принудительную оплату за скачивание файла в размере 2-3$
Уважайте чужой труд.
Над переводом трудились:
1. EginKaman - идея и организация (http://www.gmod-fan.ru/user/EginKaman/);
2. Argaron - редактирование и проверка ошибок (http://www.gmod-fan.ru/user/Argaron/);
3. DimaLaime - перевод некоторых кусков текста (http://www.gmod-fan.ru/user/DimaLaime/).

= Предупреждение =
Иногда, когда DarkRP обновляется, новые фразы добавляются.
Если вы не переведёте фразы на свой язык, будут использоваться английские фразы.
Чтобы исправить, подключитесь к вашему серверу, откройте вашу консоль и введите darkp_getphrases ваш_язык
Для русского команда должна быть такая:
    darkrp_getphrases "ru"
потому что "ru" языковый код для русского языка.

Вы можете скопировать недостающие фразы в этот файл и перевести их.

= Примечание =
Убедитесь, что код языка правильный в нижней части этого файла

= Использование языков =
Убедитесь, что ConVar gmod_language установлен ваш код языка. Вы можете изменить его в server.cfg.

---------------------------------------------------------------------------]]
local russian = {
	-- Действия администратора
	need_admin = "Вам требуются права администратора, чтобы иметь возможность %s",
	need_sadmin = "Вам требуются права супер администратора, чтобы иметь возможность %s",
	no_privilege = "У вас нет прав для совершения данного действия",
	no_jail_pos = "Отсутствуют позиции тюрьмы",
	invalid_x = "Некорректный %s! %s",

	-- меню F1
	f1ChatCommandTitle = "Команды чата",
	f1Search = "Поиск...",

	-- Денежные операции:
	price = "Цена: %s%d",
	priceTag = "Цена: %s",
	reset_money = "%s сбросил деньги всех игроков!",
	has_given = "%s дал Вам %s",
	you_gave = "Вы дали %s %s",
	npc_killpay = "%s за убийство NPC!",
	profit = "доход",
	loss = "убыток",

	-- backwards compatibility
	deducted_x = "Вычтено %s%d",
	need_x = "Требуется %s%d",

	deducted_money = "Вычтено %s",
	need_money = "Требуется %s",

	payday_message = "День выплаты зарплаты! Вы получили %s!",
	payday_unemployed = "Вы не получили зарплату, потому что вы безработный!",
	payday_missed = "День выплаты зарплаты пропущен! (Вы арестованы)",

	property_tax = "Налог на имущество! %s",
	property_tax_cant_afford = "Вы не смогли заплатить налоги! Ваше имущество было изъято у Вас!",
	taxday = "День оплаты налогов! %s%% из Вашего дохода было изъято!",

	found_cheque = "Вы нашли %s%s в чеке, который выписал %s.",
	cheque_details = "Это чек, выписанный на %s.",
	cheque_torn = "Вы разорвали чек",
	cheque_pay = "Сумма: %s",
	signed = "Подпись: %s",

	found_cash = "Вы нашли %s%d!", -- backwards compatibility
	found_money = "Вы нашли %s!",

	owner_poor = "%s слишком беден, чтобы субсидировать продажу!",

	-- Полиция
	wanted = "Разыскивается полицией!\nПричина: %s",
	youre_arrested = "Вы были арестованы на %d секунд!",
	youre_arrested_by = "Вы были арестованы %s.",
	youre_unarrested_by = "Вы были не арестованы %s.",
	hes_arrested = "%s был арестован на %d секунд!",
	hes_unarrested = "%s был освобожден из тюрьмы!",
	warrant_ordered = "%s выдал ордер на обыск %s. Причина: %s",
	warrant_request = "%s требует ордер на обыск %s\nПричина: %s",
	warrant_request2 = "Запрос ордера на обыск был отправлен мэру %s!",
	warrant_approved = "Ордер на обыск был одобрен для %s!\nПричина: %s\nЗапросил: %s",
	warrant_approved2 = "Теперь Вы можете произвести обыск.",
	warrant_denied = "Мэр %s отклонил Ваш запрос ордера на обыск.",
	warrant_expired = "Ордер на обыск %s истек!",
	warrant_required = "Вам требуется ордер на обыск, чтобы открыть эту дверь.",
	warrant_required_unfreeze = "Вам нужен ордер на разморозку пропа.",
	warrant_required_unweld = "Вам нужен ордер на снятие сварных швов этого пропа.",
	wanted_by_police = "%s разыскивается полицией!\nПричина: %s\nЗапросил: %s",
	wanted_by_police_print = "%s сделал %s разыскиваемым, причина: %s",
	wanted_expired = "%s больше не разыскивает полиция.",
	wanted_revoked = "%s больше не разыскивает полиция.\nОтменил: %s",
	cant_arrest_other_cp = "Вы не можете арестовать других CPs!",
	must_be_wanted_for_arrest = "Игрок должен быть разыскиваемым, чтобы иметь возможность арестовать его.",
	cant_arrest_fadmin_jailed = "YВы не можете арестовать игрока, который был заключен в тюрьму админом.",
	cant_arrest_no_jail_pos = "Вы не можете арестовать людей, так как нет установленных позиций тюрьмы!",
	cant_arrest_spawning_players = "Вы не можете арестовать игроков, которые спавнятся.",

	suspect_doesnt_exist = "Подозреваемый не существует.",
	actor_doesnt_exist = "Актер не существует.",
	get_a_warrant = "получить ордер",
	make_someone_wanted = "сделать кого-то разыскиваемым",
	remove_wanted_status = "удалить статус разыскиваемого",
	already_a_warrant = "Уже есть ордер на обыск подозреваемого.",
	already_wanted = "Подозреваемый уже разыскивается.",
	not_wanted = "Подозреваемый не разысиквается.",
	need_to_be_cp = "Вы должны быть полицейским.",
	suspect_must_be_alive_to_do_x = "Подозреваемый должен быть живым, чтобы %s.",
	suspect_already_arrested = "Подозреваемый сейчас в тюрьме.",

	-- Игроки
	health = "Здоровье: %s",
	job = "Работа: %s",
	salary = "Зарплата: %s%s",
	wallet = "Бумажник: %s%s",
	weapon = "Оружие: %s",
	kills = "Убийств: %s",
	deaths = "Смертей: %s",
	rpname_changed = "%s изменили свое RPName на: %s",
	disconnected_player = "Игрок отключился",

	-- Команды
	need_to_be_before = "Вы должны быть %s первый для того, чтобы стать %s",
	need_to_make_vote = "Вам нужно создать голосование, чтобы стать %s!",
	team_limit_reached = "Нельзя стать %s, из-за достигнутого лимита",
	wants_to_be = "%s\nхочет быть\n%s",
	has_not_been_made_team = "%s не стал %s!",
	job_has_become = "%s теперь %s!",

	-- Бедствия
	meteor_approaching = "ВНИМАНИЕ: метеоритный дождь приближается!",
	meteor_passing = "Метеоритный дождь прошел.",
	meteor_enabled = "Метеоритный дождь включен.",
	meteor_disabled = "Метеоритный дождь выключен.",
	earthquake_report = "Землетрясение магнитудой %sMw",
	earthtremor_report = "Подземные толчки магнитудой %sMw",

	-- Ключи, транспорт и двери
	keys_allowed_to_coown = "Вы имеете право стать совладельцем.\n(Нажмите R с ключами или нажмите F2, чтобы стать совладельцем)\n",
	keys_other_allowed = "Разрешено стать совладельцем:",
	keys_allow_ownership = "(Нажмите R с ключами или нажмите F2, чтобы разрешить право собственности)",
	keys_disallow_ownership = "(Нажмите R с ключами или нажмите F2, чтобы запретить право собственности)",
	keys_owned_by = "Владелец:",
	keys_unowned = "Нет владельца\n(Нажмите R с ключами или нажмите F2, чтобы стать владельцем)",
	keys_everyone = "(Нажмите R с ключами или нажмите F2, чтобы разрешить всем)",
	door_unown_arrested = "Вы не можете владеть или не владеть имуществом когда арестованы!",
	door_unownable = "Эта дверь не может быть собственностью или ничьей!",
	door_sold = "Вы продали это за %s",
	door_already_owned = "Эта дверь уже принадлежит кому-то!",
	door_cannot_afford = "Вы не можете позволить себе эту дверь!",
	door_hobo_unable = "Вы не можете купить дверь, если вы бродяга!",
	vehicle_cannot_afford = "Вы не можете позволить себе этот транспорт!",
	door_bought = "Вы купили эту дверь за %s%s",
	vehicle_bought = "Вы купили этот транспорт за %s%s",
	door_need_to_own = "Вы должны владеть этой дверь, чтобы иметь возможность %s",
	door_rem_owners_unownable = "Вы не можете удалять владельцев если дверь не продается!",
	door_add_owners_unownable = "Вы не можете добавлять владельцев если дверь не продается!",
	rp_addowner_already_owns_door = "%s уже владеет (или уже разрешено владеть) этой дверью!",
	add_owner = "Добавить владельца",
	remove_owner = "Удалить владельца",
	coown_x = "Совладелец %s",
	allow_ownership = "Разрешить покупать",
	disallow_ownership = "Запретить покупать",
	edit_door_group = "Редактировать группы двери",
	door_groups = "Группы двери",
	door_group_doesnt_exist = "Групп двери не существует!",
	door_group_set = "Группы двери успешно установлены.",
	sold_x_doors_for_y = "Вы продали %d дверь за %s%d!", -- backwards compatibility
	sold_x_doors = "Вы продали %d дверь за %s!",

	-- Entities
	drugs = "Наркотики",
	drug_lab = "Лаборатория наркотиков",
	gun_lab = "Оружейная лаборатория",
	gun = "Оружие",
	microwave = "Микроволновая печь",
	food = "Еда",
	money_printer = "Денежный принтер",

	sign_this_letter = "Подпишите письмо",
	signed_yours = "Ваш,",

	money_printer_exploded = "Ваш денежный принтер взорвался!",
	money_printer_overheating = "Ваш денежный принтер перегрелся!",

	contents = "Содержание: ",
	amount = "Количество: ",

	picking_lock = "Выбор замка",

	cannot_pocket_x = "Вы не можете поместить это в Ваш карман!",
	object_too_heavy = "Объект слишком тяжелый.",
	pocket_full = "Ваш карман полный!",
	pocket_no_items = "Ваш карман не содержит предметов.",
	drop_item = "Выбросить предметы",

	bonus_destroying_entity = "бонус за уничтожение незаконного объекта.",

	switched_burst = "Переключено на огонь очередями.",
	switched_fully_auto = "Переключено на автоматический огонь.",
	switched_semi_auto = "Переключено на полуавтоматический режим стрельбы.",

	keypad_checker_shoot_keypad = "Стрельните в цифровую клавиатуру, чтобы увидеть, что она контролирует.",
	keypad_checker_shoot_entity = "Стрельните в объект, чтобы увидеть, какие цифровые клавиатуры подключены",
	keypad_checker_click_to_clear = "Правый клик для очистки.",
	keypad_checker_entering_right_pass = "Ввод правильного пароля",
	keypad_checker_entering_wrong_pass = "Ввод неправильного пароля",
	keypad_checker_after_right_pass = "после ввода правильного пароля",
	keypad_checker_after_wrong_pass = "после ввода неправильного пароля",
	keypad_checker_right_pass_entered = "Введен правильный пароль",
	keypad_checker_wrong_pass_entered = "Введен неправильный пароль",
	keypad_checker_controls_x_entities = "Цифровая клавиатура контролирует %d объектов",
	keypad_checker_controlled_by_x_keypads = "Объект контролируется %d цифровыми клавиатурами",
	keypad_on = "ON",
	keypad_off = "OFF",
	seconds = "секунд",

	persons_weapons = "%s's нелегального оружия:",
	returned_persons_weapons = "Возвращено %s's конфискованного оружия.",
	no_weapons_confiscated = "%s нет конфискованного оружия!",
	no_illegal_weapons = "%s нет нелегального оружия.",
	confiscated_these_weapons = "Конфисковано оружие:",
	checking_weapons = "Проверить оружие",

	shipment_antispam_wait = "Пожалуйста, подождите перед спавном нового товара.",

	-- Talking
	hear_noone = "Никто не слышит вашу %s!",
	hear_everyone = "Тебя все слышат!",
	hear_certain_persons = "Игроки, которые могут Вас слышать %s: ",

	whisper = "шепот",
	yell = "крик",
	advert = "[Объявление]",
	broadcast = "[Вещание!]",
	radio = "радио",
	request = "(ЗАПРОС!)",
	group = "(группа)",
	demote = "(РАЗЖАЛОВАН)",
	ooc = "Глобальный",
	radio_x = "Радио %d",

	talk = "сказать",
	speak = "речь",

	speak_in_ooc = "говорить в OOC",
	perform_your_action = "выполнять свои действия",
	talk_to_your_group = "говорить со своей группой",

	channel_set_to_x = "Канал изменен на %s!",

	-- Notifies
	disabled = "%s отключено! %s",
	gm_spawnvehicle = "Вызов транспорта",
	gm_spawnsent = "Вызов заскриптованых объектов (SENTs)",
	gm_spawnnpc = "Вызов неигровых персонажей (NPCs)",
	see_settings = "Пожалуйста, посмотрите настройки DarkRP.",
	limit = "Вы достигли %s лимита!",
	have_to_wait = "Нужно подождать еще %d секунд перед использованием %s!",
	must_be_looking_at = "Вы должны смотреть на %s!",
	incorrect_job = "Вы не имеете право на работу %s",
	unavailable = "%s недоступно",
	unable = "Вы не в состоянии %s. %s",
	cant_afford = "Вы не можете себе позволить %s",
	created_x = "%s создал %s",
	cleaned_up = "Ваши %s были очищены.",
	you_bought_x = "Вы купили %s за %s%d.", -- backwards compatibility
	you_bought = "Вы купили %s за %s.",
	you_received_x = "Вы получили %s для %s.",
	you_received_x = "Вы получили %s для %s.",

	created_first_jailpos = "Вы должны установить для начала координаты тюрьмы!",
	added_jailpos = "Вы должны добавить одну дополнительную позицию тюрьмы!",
	reset_add_jailpos = "Вы удалили все позиции тюрьмы и добавили новую здесь.",
	created_spawnpos = "%s's позиция спавна создана.",
	updated_spawnpos = "%s's позиция спавна обновлена.",
	do_not_own_ent = "Вы не владеете этим объектом!",
	cannot_drop_weapon = "Невозможно выбросить оружие!",
	job_switch = "Работа успешно переключена!",
	job_switch_question = "Переключение работ с %s?",
	job_switch_requested = "Работа требует включения.",

	cooks_only = "Только для поваров.",

	-- Misc
	unknown = "Неизвестно",
	arguments = "аргумент",
	no_one = "ни один",
	door = "Дверь",
	vehicle = "Транспорт",
	door_or_vehicle = "Дверь/Транспорт",
	driver = "Водитель: %s",
	name = "Имя: %s",
	locked = "Заблокировано.",
	unlocked = "Разблокировано.",
	player_doesnt_exist = "Игрок не найден.",
	job_doesnt_exist = "Работа не найдена!",
	must_be_alive_to_do_x = "Вы должны быть живы, чтобы %s.",
	banned_or_demoted = "Забанен/Разжалован",
	wait_with_that = "Подождите с этим.",
	could_not_find = "Не удалось найти %s",
	f3tovote = "Нажмите F3 для голосования",
	listen_up = "Слушайте:", -- На rp_tell или rp_tellall
	nlr = "Новое правило жизни: Не мстить за себя арестом/убийством.",
	reset_settings = "Вы сбросили все настройки!",
	must_be_x = "Вы должны быть %s для того чтобы иметь возможность %s.",
	agenda_updated = "Повестка дня была обновлена",
	job_set = "%s установил его/её работу на '%s'",
	demoted = "%s был разжалован",
	demoted_not = "%s не может быть разжалован",
	demote_vote_started = "%s начал голосование за понижение в должности %s",
	demote_vote_text = "Кандидат на разжалование:\n%s", -- '%s' is the reason here
	cant_demote_self = "Вы не можете понизить себя.",
	i_want_to_demote_you = "Я хочу понизить вас. Причина: %s",
	tried_to_avoid_demotion = "Вы пытались избежать понижения. Вам не удалось и были разжалованы.", -- naughty boy!
	lockdown_started = "Мэр проводит комендантский час, пожалуйста вернитесь в свои дома!!",
	lockdown_ended = "Комендантский час закончен",
	gunlicense_requested = "%s запросил %s лицензию на оружие",
	gunlicense_granted = "%s предоставил %s лицензию на оружие",
	gunlicense_denied = "%s отказал %s лицензию на оружие",
	gunlicense_question_text = "Выдать %s лицензию на оружие?",
	gunlicense_remove_vote_text = "%s начал голосование на удаление лицензии на оружие %s",
	gunlicense_remove_vote_text2 = "Аннулировать лицензию на оружие:\n%s", -- Where %s is the reason
	gunlicense_removed = "%s's лицензия была удалена!",
	gunlicense_not_removed = "%s's лицензия не удалена!",
	vote_specify_reason = "Вы должны указать причину!",
	vote_started = "Голосование создано",
	vote_alone = "Вы выиграли голосвание, так как вы один на сервере.",
	you_cannot_vote = "Вы не можете голосовать!",
	x_cancelled_vote = "%s отменил последнее голосование.",
	cant_cancel_vote = "Не удалось отменить последнее голосование так, как не было последнего голосования для отмены!",
	jail_punishment = "Наказание за отключение! Заключенный в тюрьму на: %d seconds.",
	admin_only = "Только для администратора!", -- When doing /addjailpos
	chief_or = "Главный или ",-- When doing /addjailpos
	frozen = "Замороженный.",

	dead_in_jail = "Вы сейчас мертвы, пока ваше время в тюрьме не истекло!",
	died_in_jail = "%s умер в тюрьме!",

	credits_for = "КРЕДИТЫ ДЛЯ %s\n",
	credits_see_console = "DarkRP кредиты напечатаны в консоли.",

	rp_getvehicles = "Свободный транспорт для пользовательского транспорта:",

	data_not_loaded_one = "Ваши данные еще не были загружены. Пожалуйста, подождите.",
	data_not_loaded_two = "Если не удается, попробуй переподключится или связатся с администратором",

	cant_spawn_weapons = "Вы не можете вызывать оружие.",
	drive_disabled = "Вождение сейчас отключено.",
	property_disabled = "Недвижимость отключена сейчас.ы",

	not_allowed_to_purchase = "Вы не можете купить этот предмет.",

	rp_teamban_hint = "rp_teamban [player name/ID] [team name/id]. Используйте, чтобы забанить игрока с определенной команды.",
	rp_teamunban_hint = "rp_teamunban [player name/ID] [team name/id]. Используйте, чтобы разбанить игрока с определенной команды.",
	x_teambanned_y = "%s забанен %s от %s.",
	x_teamunbanned_y = "%s разбанен %s от %s.",

	-- Backwards compatibility:
	you_set_x_salary_to_y = "Вы установили зарплату %s's на %s%d.",
	x_set_your_salary_to_y = "%s установил вашу зарплату на %s%d.",
	you_set_x_money_to_y = "Вы установили деньги %s's на %s%d.",
	x_set_your_money_to_y = "%s установил ваши деньги на %s%d.",

	you_set_x_salary = "Вы установили зарплату %s's на %s.",
	x_set_your_salary = "%s установил ваши зарплату на %s.",
	you_set_x_money = "Вы установили деньги %s's на %s.",
	x_set_your_money = "%s установил ваши деньги на %s.",
	you_set_x_name = "Вы установили имя %s's на %s",
	x_set_your_name = "%s установил ваше имя на %s",

	someone_stole_steam_name = "Кто-то уже использует ваше имя Steam как RP имя поэтому мы дали '1' после вашего имени.", -- Uh oh
	already_taken = "Уже приняты.",

	job_doesnt_require_vote_currently = "Эта работа не требует голосования на данный момент!",

	x_made_you_a_y = "%s сделал вас %s!",

	cmd_cant_be_run_server_console = "Эта команда не может быть запущена с консоли сервера.",

	-- The lottery
	lottery_started = "Лотерея! Участвовать в %s%d?", -- backwards compatibility
	lottery_has_started = "Лотерея! Участвовать в %s?",
	lottery_entered = "Вы вошли в лотерею %s",
	lottery_not_entered = "%s не участвует в лотерее",
	lottery_noone_entered = "Никто не вошел в лотерею",
	lottery_won = "%s выиграл в лотерею! Он выиграл %s",

	-- Animations
	custom_animation = "Пользовательская анимация!",
	bow = "Поклон",
	dance = "Танцевать",
	follow_me = "Следуй за мной!",
	laugh = "Смеяться",
	lion_pose = "Поза льва",
	nonverbal_no = "Non-verbal no",
	thumbs_up = "Палец вверх!",
	wave = "Волна",

	-- Hungermod
	starving = "Голодный!",

	-- AFK
	afk_mode = "AFK режим",
	salary_frozen = "Ваша зарплата была заморожена.",
	salary_restored = "Добро пожаловать, Ваша зарплата была восстановлена.",
	no_auto_demote = "Вы не будете автоматически разжалованы.",
	youre_afk_demoted = "Вы были понижены в должности за то, что слишком долго отсутствовали. В следующий раз используйте /afk.",
	hes_afk_demoted = "%s разжалован из-за слишком долгого отсутствия.",
	afk_cmd_to_exit = "Напишите /afk снова, для выхода из AFK режима.",
	player_now_afk = "%s сейчас AFK.",
	player_no_longer_afk = "%s больше не AFK.",

	-- Hitmenu
    hit = "заказ",
    hitman = "Убийца",
    current_hit = "Заказ: %s",
    cannot_request_hit = "Нельзя сделать заказ! %s",
    hitmenu_request = "Заказ",
    player_not_hitman = "Этот игрок не принимает заказы!",
    distance_too_big = "Подойдите ближе.",
    hitman_no_suicide = "Убийца не принимает заказ на себя.",
    hitman_no_self_order = "Наемный убийца не может сделать заказ на себя.",
    hitman_already_has_hit = "Убийца уже занят другим заказом.",
    price_too_low = "Цена слишком мала!",
    hit_target_recently_killed_by_hit = "Цель уже была недавно убита,",
    customer_recently_bought_hit = "Клиент уже недавно делал заказ.",
    accept_hit_question = "Принять заказ от %s\nЦена: %s Цель: %s%d?", -- backwards compatibility
    accept_hit_request = "Принять заказ от %s\nЦена: %s Цель: %s?",
    hit_requested = "Заказ сделан!",
    hit_aborted = "Заказ отменен! %s",
    hit_accepted = "Заказ принят!",
    hit_declined = "Убийца отказался от заказа!",
    hitman_left_server = "Убийца покинул сервер!",
    customer_left_server = "Клиент покинул сервер!",
    target_left_server = "Цель покинула сервер!",
    hit_price_set_to_x = "Цена изменена до: %s%d.", -- backwards compatibility
    hit_price_set = "Цена изменена до: %s.",
    hit_complete = "Заказ %s выполнен!",
    hitman_died = "Убийца умер!",
    target_died = "Цель умерла!",
    hitman_arrested = "Убийцу арестовали!",
    hitman_changed_team = "Убийца сменил работу!",
    x_had_hit_ordered_by_y = "%s имел заказ от %s",

	-- Vote Restrictions
	hobos_no_rights = "Бродяги не имеют права голоса!",
	gangsters_cant_vote_for_government = "Гангстеры не могут голосовать за правительственные вещи!",
	government_cant_vote_for_gangsters = "Правительство не может голосовать за гангстерские вещей!",

	-- VGUI and some more doors/vehicles
	vote = "Голосование",
	time = "Время: %d",
	yes = "Да",
	no = "Нет",
	ok = "Окей",
	cancel = "Отмена",
	add = "Добавить",
	remove = "Удалить",
	none = "None",

	x_options = "%s опции",
	sell_x = "Продать %s",
	set_x_title = "Установить название %s ",
	set_x_title_long = "Установить название %s you are looking at.",
	jobs = "Работы",
	buy_x = "Купить %s",

	-- F4menu
	no_extra_weapons = "Эта работа не имеет дополнительного оружия",
	become_job = "Устроится на работу",
	create_vote_for_job = "Создать голосование",
	shipments = "Товары",
	F4guns = "Оружие",
	F4entities = "Разное",
	F4ammo = "Патроны",
	F4vehicles = "Транспорт",

	-- Tab 1
	give_money = "Дать денег игроку, на которого смотрите",
	drop_money = "Выбросить деньги",
	change_name = "Изменить имя DarkRP",
	go_to_sleep = "Спать/Просыпаться",
	drop_weapon = "Выбросить текущее оружие",
	buy_health = "Купить здоровье(%s)",
	request_gunlicense = "Запрос на лицензию оружия",
	demote_player_menu = "Понизить игрока",


	searchwarrantbutton = "Сделать игрока разыскиваемым",
	unwarrantbutton = "Снять статус розыска с игрока",
	noone_available = "Нет доступных",
	request_warrant = "Запрос ордера на обыск для игрока",
	make_wanted = "Сделать кого-то разыскиваемым",
	make_unwanted = "Сделать кого-то не разыскиваемым",
	set_jailpos = "Установить позицию тюрьмы",
	add_jailpos = "Добавить позицию тюрьмы",

	set_custom_job = "Установить пользовательскую работу (нажмите enter для активации)",

	set_agenda = "Установить повестку дня (нажмите enter для активации)",

	initiate_lockdown = "Инициировать комендантский час",
	stop_lockdown = "Остановить блокировку",
	start_lottery = "Начать лотерею",
	give_license_lookingat = "Выдать <lookingat> лицензию на оружие",

	laws_of_the_land = "ЗАКОНЫ ШТАТА",
	law_added = "Закон добавлен.",
	law_removed = "Закон удален.",
	law_reset = "Законы сброшены.",
	law_too_short = "Список законов слишком короткий.",
	laws_full = "Список законов полон.",
	default_law_change_denied = "Вы не можете изменить основные законы.",

	-- Second tab
	job_name = "Имя: ",
	job_description = "Описание: ",
	job_weapons = "Оружие: ",

	-- Entities tab
	buy_a = "Куплено %s: %s",
	
	

	-- Licenseweaponstab
	license_tab = [[Лицензия на оружие

	Отметьте оружие, которое люди могут получить без лицензии!
	]],
	license_tab_other_weapons = "Другое оружие:",
}

DarkRP.addLanguage("ru", russian) -- Make sure "en" is a valid entry for the convar gmod_language.
