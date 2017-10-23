DROP TABLE IF EXISTS burger_deal;
DROP TABLE IF EXISTS deal;
DROP TABLE IF EXISTS burger;
DROP TABLE IF EXISTS eatery;

CREATE TABLE eatery (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255),
  address     VARCHAR(255),
  telephone   VARCHAR(255),
  email       VARCHAR(255),
  website_url VARCHAR(255),
  image_url   VARCHAR(255)
);

CREATE TABLE burger (
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(255),
  price     REAL,
  eatery_id INT REFERENCES eatery (id) ON DELETE CASCADE
);

CREATE TABLE deal (
  id            SERIAL PRIMARY KEY,
  name          VARCHAR(255),
  day           INT,
  discount_rate REAL,
  eatery_id     INT REFERENCES eatery (id) ON DELETE CASCADE
);

CREATE TABLE burger_deal (
  id        SERIAL PRIMARY KEY,
  burger_id INT REFERENCES burger (id) ON DELETE CASCADE,
  deal_id   INT REFERENCES deal (id) ON DELETE CASCADE
);

INSERT INTO eatery (name, address, telephone, email, website_url, image_url)
VALUES (
  'Bread Meats Bread',
  '92 Lothian Road, Edinburgh, EH3 9BE',
  '0131 225 3000',
  'info@breadmeatsbread.com',
  'http://breadmeatsbread.com/',
  'http://breadmeatsbread.com/images/bread-meats-bread-logo.png'
);

INSERT INTO burger (name, price, eatery_id)
VALUES (
  'Chicken, Cheese & Bacon',
  9.50,
  1
);

INSERT INTO deal (name, day, discount_rate, eatery_id)
VALUES (
  '15% off',
  1,
  15,
  1
);

INSERT INTO burger_deal (burger_id, deal_id) VALUES (1, 1);

DELETE FROM eatery;
DELETE FROM burger;
DELETE FROM deal;
DELETE FROM burger_deal;

SELECT *
FROM eatery;
SELECT *
FROM burger;
SELECT *
FROM deal;
SELECT *
FROM burger_deal;

/* Get burger details and calculate new price from its associated deal */
SELECT
  burger.name,
  burger.price                                    AS old_price,
  burger.price / 100 * (100 - deal.discount_rate) AS new_price,
  deal.name
FROM burger
  INNER JOIN burger_deal
    ON burger.id = burger_deal.burger_id
  INNER JOIN deal
    ON deal_id = burger_deal.deal_id;

/* Get eatery for a particular burger */
SELECT *
FROM eatery
WHERE id = 1;

/* Get all burgers for an eatery */
SELECT *
FROM burger
WHERE eatery_id = 1;

/* Count burgers for an eatery */
SELECT count(id)
FROM burger
WHERE eatery_id = 1;

/* Get all deals for an eatery */
SELECT *
FROM deal
WHERE eatery_id = 1;

/* Get all deals for an eatery for a particular day */
SELECT *
FROM deal
WHERE eatery_id = 1 AND day = 1;

/* Count all deals */
SELECT count(*)
FROM deal;

/* Count deals for an eatery */
SELECT count(*)
FROM deal
WHERE eatery_id = 1;

/* Get full name of deal including the eatery name */
SELECT concat(deal.name, ' at ', eatery.name) AS full_deal_name
FROM deal
  INNER JOIN eatery
    ON deal.eatery_id = eatery.id;

/* Get burgers in all deals for a given day */
SELECT
  burger.name AS burger_name,
  deal.name   AS deal_name
FROM burger
  INNER JOIN burger_deal
    ON burger_deal.burger_id = burger.id
  INNER JOIN deal
    ON burger_deal.deal_id = deal.id
WHERE deal.day = 1;
