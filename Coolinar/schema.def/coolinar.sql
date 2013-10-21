PRAGMA foreign_keys = ON;

--
-- Recipes table
-- 
-- left out fields: 
--     - ingredients
--     - users who creates it
--
CREATE TABLE recipes (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       name VARCHAR(128) NOT NULL,
       desc TEXT NOT NULL,
       img BLOB,
       thumbnail BLOB,
       when_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
       when_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
       id iNTEGER PRIMARY KEY AUTOINCREMENT,
       role VARCHAR(32) NOT NULL,
       desc TEXT
);

CREATE TABLE users (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       name VARCHAR(32),
       -- left out: address/user info, user stat
       pass VARCHAR(32),
       r_id INT REFERENCES ROLES(id),
       when_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
       when_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE comments (
       id INTEGER PRIMARY KEY  AUTOINCREMENT,
       u_id INT REFERENCES USERS(id),
       r_id INT REFERENCES RECIPES(id),
       rate INT,
       post TEXT,
       when_posted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- TODO: multiple recipe authors support
--
CREATE TABLE recipe_author (
       r_id INT REFERENCES RECIPES(id),
       u_id INT REFERENCES USERS(id)
);

INSERT INTO roles(id, role) VALUES(1, 'guest');
INSERT INTO roles(id, role) VALUES(2, 'user' );
INSERT INTO roles(id, role) VALUES(3, 'admin');

INSERT INTO users(name, pass, r_id) VALUES( 'guest',  'guest',  2 );
INSERT INTO users(name, pass, r_id) VALUES( 'guest1', 'guest1', 2 );

INSERT INTO recipes(name, desc) VALUES( 'Бутерброд (с белым хлебом)', 'Берём буханку, отрезаем ломтик (не менее 3 см в ширину), намазываем масло, кладём сверху заготовленную котлету (см рецепт по приготовлению котлет по киевски)');
INSERT INTO recipes(name, desc) VALUES( 'Чай', 'Греем воду (не менее 300 мл) до состояния кипения, устанавливаем покетик с чаем в кружку, таким образом чтобы нить с захватом оставалась вне кружки, наливаем в кружку подогретую воду. Не долеваем до бортика (края) кружки несколько сантиметорв. По желанию добовляем сахар, но не более двух ложек. Подождать несколько минут, пока температура воды понизится, а чай зварится.');
INSERT INTO recipes(name, desc) VALUES( 'Хот-Дог', 'Очень долго рассказывать, но варим несколко минут сосиску, затем берём булку, разрезаем на две части (вдоль), кладём в неё упомянутую сосиску, льём сверху кетчуп');

--
-- Local Variables:
-- coding: utf-8
-- End:
-- 