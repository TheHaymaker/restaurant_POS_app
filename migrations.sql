CREATE DATABASE rest_app;
\c rest_app

CREATE TABLE foods (
	id SERIAL PRIMARY KEY, 
	cents INTEGER, 
	cuisine_type VARCHAR(255), 
	allergens VARCHAR(255),
	name VARCHAR(255)
);

CREATE TABLE parties (
	id SERIAL PRIMARY KEY,
	table_number INTEGER,
	num_of_guests INTEGER,
	pay_yet BOOLEAN
);

CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	food_id INTEGER REFERENCES foods(id),
	party_id INTEGER REFERENCES parties(id)
);

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	username VARCHAR(255),
	password_hash VARCHAR(255)
);