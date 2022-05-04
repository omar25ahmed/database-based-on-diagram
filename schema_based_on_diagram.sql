/* Database schema to keep the structure of entire database. */

CREATE TABLE patients (
	id int generated always as identity,
	name varchar(250),
	date_of_birth date,
	PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
	id int generated always as identity,
	admitted_at timestamp,
	patient_id int,
	status varchar(250),
	PRIMARY KEY (id)
);


CREATE TABLE treatments (
	id int generated always as identity,
	type varchar(250),
	name varchar(250),
	PRIMARY KEY (id)
);

CREATE TABLE invoices (
	id int generated always as identity,
	total_amount decimal,
	generated_at timestamp,
	medical_history_id int,
	PRIMARY KEY (id)
);

CREATE TABLE invoices_items (
	id int generated always as identity,
	unit_price decimal,
	quantity int,
	total_price decimal,
	invoice_id int,
	treatment_id int,
	PRIMARY KEY (id)
);

