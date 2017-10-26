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
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255),
  description VARCHAR(1024),
  price       REAL,
  eatery_id   INT REFERENCES eatery (id) ON DELETE CASCADE,
  image_url   VARCHAR(255)
);

CREATE TABLE deal (
  id            SERIAL PRIMARY KEY,
  name          VARCHAR(255),
  day           VARCHAR(16),
  discount_rate REAL,
  eatery_id     INT REFERENCES eatery (id) ON DELETE CASCADE
);

CREATE TABLE burger_deal (
  id        SERIAL PRIMARY KEY,
  burger_id INT REFERENCES burger (id),
  deal_id   INT REFERENCES deal (id)
);