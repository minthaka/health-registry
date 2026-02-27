CREATE TYPE Status AS ENUM (
'INITIALIZATION',
'SUCCESS',
'FAILED'
);

CREATE TYPE Command AS ENUM (
'CREATE_USER',
'USER_CREATION_ERROR',
'USER_CREATED',
'CREATE_DOCTOR',
'DOCTOR_CREATION_ERROR',
'DOCTOR_CREATED',
'CREATE_APPOINTMENT',
'APPOINTMENT_CREATION_ERROR',
'APPOINTMENT_CREATED',
'SEND_OUT_MAILS',
'MAIL_ERROR',
'MAIL_SENT',
'DOCTOR_CREATED_ELASTIC'
);

CREATE TABLE requests(
    request_id uuid,
    status Status NOT NULL,
    payload JSONB,
    last_updated TIMESTAMP,
    payload_hash VARCHAR(1024),
    "version" BIGINT,
    CONSTRAINT requests_pkey PRIMARY KEY (request_id)
);
-- One outbox table per service

CREATE TABLE outbox_doctor(
	outbox_id uuid NOT NULL,
	request_id uuid NOT NULL,
	type Command NOT NULL,
	payload JSONB,
	created_at TIMESTAMP,
	processed boolean,
	"version" BIGINT,
	CONSTRAINT outbox_doctor_pkey PRIMARY KEY (outbox_id)
);

CREATE TABLE outbox_appointment(
	outbox_id uuid NOT NULL,
	request_id uuid NOT NULL,
	type Command NOT NULL,
	payload JSONB,
	created_at TIMESTAMP,
	processed boolean,
	"version" BIGINT,
	CONSTRAINT outbox_appointment_pkey PRIMARY KEY (outbox_id)
);

CREATE TABLE outbox_mails(
	outbox_id uuid NOT NULL,
	request_id uuid NOT NULL,
	type Command NOT NULL,
	payload JSONB,
	created_at TIMESTAMP,
	processed boolean,
	"version" BIGINT,
	CONSTRAINT outbox_mails_pkey PRIMARY KEY (outbox_id)
);

CREATE INDEX idx_outbox_order_processed ON outbox_order(processed) WHERE processed = false;
CREATE INDEX idx_outbox_orchestrator_processed ON outbox_orchestrator(processed) WHERE processed = false;
CREATE INDEX idx_outbox_payment_processed ON outbox_payment(processed) WHERE processed = false;
CREATE INDEX idx_outbox_inventory_processed ON outbox_inventory(processed) WHERE processed = false;

