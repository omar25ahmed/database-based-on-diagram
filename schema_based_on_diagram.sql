CREATE TABLE patients (
	id int generated always as identity,
	name varchar(250),
	date_of_birth date,
	PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
	id int generated always as identity,
	admitted_at timestamp,
	patient_id int REFERENCES patients (id),
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
	medical_history_id int REFERENCES medical_histories(id) ,
	PRIMARY KEY (id)
);

CREATE TABLE invoices_items (
	id int generated always as identity,
	unit_price decimal,
	quantity int,
	total_price decimal,
	invoice_id int REFERENCES invoices (id),
	treatment_id int REFERENCES treatments (id) ,
	PRIMARY KEY (id)
);

CREATE TABLE medical_histories_treatments (
	medical_history_id int REFERENCES medical_histories(id), 
	treatment_id int REFERENCES treatments(id)
);


-- Creating foreign keys indexes
CREATE INDEX IF NOT EXISTS medical_histories_index
    ON public.medical_histories USING btree
    (patient_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medical_histories
    CLUSTER ON medical_histories_index;


CREATE INDEX IF NOT EXISTS medical_histories_treatments_treatment_index
    ON public.medical_histories_treatments USING btree
    (treatment_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medical_histories_treatments
    CLUSTER ON medical_histories_treatments_treatment_index;



CREATE INDEX IF NOT EXISTS medical_histories_treatments_medical_index
    ON public.medical_histories_treatments USING btree
    (medical_history_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medical_histories_treatments
    CLUSTER ON medical_histories_treatments_medical_index;



CREATE INDEX IF NOT EXISTS invoice_items_treatment_index
    ON public.invoices_items USING btree
    (treatment_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoices_items
    CLUSTER ON invoice_items_treatment_index;




CREATE INDEX IF NOT EXISTS invoice_items_invoiceid_index
    ON public.invoices_items USING btree
    (invoice_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoices_items
    CLUSTER ON invoice_items_invoiceid_index;



CREATE INDEX IF NOT EXISTS invoices_medical_history_index
    ON public.invoices USING btree
    (medical_history_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoices
    CLUSTER ON invoices_medical_history_index;
