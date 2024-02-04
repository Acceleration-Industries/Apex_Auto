--Welcome to Apex Auto!

CREATE TABLE "customers" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(30),
  "last_name" VARCHAR(30),
  "phone_number" VARCHAR(20),
  "email_address" VARCHAR(20),
  "address" VARCHAR(50),
  "payment" VARCHAR(50),
  PRIMARY KEY ("customer_id")
);

CREATE TABLE "car" (
  "car_id" SERIAL,
  "price" NUMERIC(10,2),
  "model" VARCHAR(30),
  "new_car" BOOLEAN,
  "customer_id" INTEGER,
  PRIMARY KEY ("car_id"),
  CONSTRAINT "FK_car.customer_id"
    FOREIGN KEY ("customer_id")
      REFERENCES "customers"("customer_id")
);

CREATE TABLE "mechanics" (
  "mec_id" SERIAL,
  "first_name" VARCHAR(30),
  "last_name" VARCHAR(30),
  "phone_number" VARCHAR(20),
  PRIMARY KEY ("mec_id")
);

CREATE TABLE "service_ticket" (
  "service_ticket_id" SERIAL,
  "service_done" VARCHAR(30),
  "service_total" NUMERIC(6,2),
  "service_date" DATE,
  "mec_id" INTEGER,
  "car_id" INTEGER,
  PRIMARY KEY ("service_ticket_id"),
  CONSTRAINT "FK_service_ticket.car_id"
  FOREIGN KEY ("car_id")
  REFERENCES "car"("car_id"),
  CONSTRAINT "FK_service_ticket.mec_id"
  FOREIGN KEY ("mec_id")
  REFERENCES "mechanics"("mec_id")
);

CREATE TABLE "sales_staff" (
  "salesstaff_id" SERIAL,
  "first_name" VARCHAR(30),
  "last_name" VARCHAR(30),
  "phone_number" VARCHAR(20),
  "email_address" VARCHAR(20),
  PRIMARY KEY ("salesstaff_id")
);

CREATE TABLE "invoice" (
  "invoice_id" SERIAL,
  "invoice_date" DATE,
  "salesstaff_id" INTEGER,
  "car_id" INTEGER,
  PRIMARY KEY ("invoice_id"),
  CONSTRAINT "FK_invoice.salesstaff_id"
  FOREIGN KEY ("salesstaff_id")
  REFERENCES "sales_staff"("salesstaff_id"),
  CONSTRAINT "FK_invoice.car_id"
  FOREIGN KEY ("car_id")
  REFERENCES "car"("car_id")
);

--__________________________________________________________________________________________________________________________________________________--

ALTER TABLE "sales_staff" ALTER COLUMN "email_address" TYPE VARCHAR(50);
ALTER TABLE "service_ticket"
ALTER COLUMN "service_total" TYPE NUMERIC(10,2);
ALTER TABLE customers
ALTER COLUMN "phone_number" TYPE VARCHAR(40);
ALTER TABLE customers
ALTER COLUMN "email_address" TYPE VARCHAR(70);
ALTER TABLE "car" ADD COLUMN "salesstaff_id" INTEGER;
ALTER TABLE "car"
ADD CONSTRAINT "FK_car.salesstaff_id"
FOREIGN KEY ("salesstaff_id")
REFERENCES "sales_staff"("salesstaff_id");
ALTER TABLE "invoice" ADD COLUMN "customer_id" INTEGER;
ALTER TABLE "invoice"
ADD CONSTRAINT "FK_invoice.customer_id"
FOREIGN KEY ("customer_id")
REFERENCES "customers"("customer_id");
ALTER TABLE "service_ticket" ADD COLUMN "customer_id" INTEGER;
ALTER TABLE "service_ticket"
ADD CONSTRAINT "FK_service_ticket.customer_id"
FOREIGN KEY ("customer_id")
REFERENCES "customers"("customer_id");
CREATE TABLE "parts" (
  "part_id" SERIAL,
  "part_name" VARCHAR(50),
  PRIMARY KEY ("part_id")
);
ALTER TABLE "parts" ADD COLUMN "used_in_service" BOOLEAN;
ALTER TABLE "service_ticket" ADD COLUMN "parts_used" VARCHAR(255);
--_________________________________________________________________________________________________________________________________________________--

INSERT INTO "customers" ("first_name", "last_name", "phone_number", "email_address", "address", "payment") VALUES
('Lewis', 'Hamilton', '555-123-4567', 'lewis@racing.com', '123 Main St', 'Credit Card'),
('Sebastian', 'Vettel', '555-234-5678', 'sebastian@racing.com', '456 Oak St', 'PayPal'),
('Fernando', 'Alonso', '555-345-6789', 'fernando@racing.com', '789 Elm St', 'Cash'),
('Scott', 'Dixon', '555-456-7890', 'scott@racing.com', '101 Pine St', 'Debit Card'),
('Kyle', 'Busch', '555-567-8901', 'kyle@racing.com', '202 Cedar St', 'Check'),
('Valentino', 'Rossi', '555-678-9012', 'valentino@racing.com', '303 Maple St', 'Bank Transfer'),
('Danica', 'Patrick', '555-789-0123', 'danica@racing.com', '404 Birch St', 'Cash App'),
('Lando', 'Norris', '555-890-1234', 'lando@racing.com', '505 Pine St', 'Venmo'),
('Chase', 'Elliott', '555-901-2345', 'chase@racing.com', '606 Cedar St', 'Apple Pay'),
('Simona', 'de Silvestro', '555-012-3456', 'simona@racing.com', '707 Elm St', 'Google Pay');

INSERT INTO "car" ("price", "model", "new_car", "customer_id") VALUES
(519999.00, 'Porsche 911 GT3 RS', TRUE, 1),
(699999.00, 'Ferrari SF90', FALSE, 2),
(200386.00, 'Aston Martin Vantage', TRUE, 3),
(309998.00, 'Lamborghini Huracan', FALSE, 4),
(358385.00, 'Bentley Continental GT', TRUE, 5),
(269998.00, 'McLaren 720S', FALSE, 6),
(3000000.00, 'Koenigsegg Jesko', TRUE, 7),
(3390000.00, 'Bugatti Chiron', FALSE, 8),
(2586547.00, 'Pagani Huayra', FALSE, 9),
(3000000.00, 'Hennessey Venom F5', TRUE, 10);

INSERT INTO "invoice" ("invoice_id", "invoice_date", "car_id") VALUES
(1, '2023-03-15', 1),
(2, '2023-05-22', 2),
(3, '2023-07-08', 3),
(4, '2023-09-14', 4),
(5, '2023-10-30', 5),
(6, '2023-04-18', 6),
(7, '2023-06-27', 7),
(8, '2023-08-09', 8),
(9, '2023-11-12', 9),
(10, '2023-12-20', 10);

INSERT INTO "mechanics" ("first_name", "last_name", "phone_number") VALUES
('Paul', 'Newman', '415-123-4567'),
('Audrey', 'Hepburn', '408-234-5678'),
('Steve', 'McQueen', '650-345-6789'),
('Marilyn', 'Monroe', '707-456-7890'),
('Sean', 'Connery', '818-567-8901');

INSERT INTO "sales_staff" ("first_name", "last_name", "phone_number", "email_address") VALUES
('Sam', 'Taggart', '714-555-1122', 'sam.taggart@apexauto.com'),
('Napoleon', 'Barragan', '949-555-2233', 'napoleon.barragan@apexauto.com'),
('Joe', 'Girard', '714-555-3344', 'joe.girard@apexauto.com'),
('Zig', 'Ziglar', '949-555-4455', 'zig.ziglar@apexauto.com'),
('Erica', 'Feidner', '714-555-5566', 'erica.feidner@apexauto.com'),
('Jordan', 'Belfort', '949-555-6677', 'jordan.belfort@apexauto.com'),
('Mary', 'Kay Ash', '714-555-7788', 'marykay.ash@apexauto.com');

INSERT INTO "service_ticket" ("service_done", "service_total", "service_date") VALUES
('engine_upgrade', 5000.00, '2023-01-15'),
('turbo_install', 8000.00, '2023-02-25'),
('exhaust_upgrade', 10000.00, '2023-03-12'),
('ecu_tuning', 12000.00, '2023-04-18'),
('suspension_setup', 6000.00, '2023-05-21'),
('aero_enhancement', 9000.00, '2023-06-08'),
('wheel_upgrade', 7500.00, '2023-07-14'),
('brake_upgrade', 5000.00, '2023-08-30'),
('race_suspension', 6500.00, '2023-09-19'),
('exhaust_setup', 8000.00, '2023-10-05');

--____________________________________________________3 INSERTS USING FUNCTIONS_____________________________________________________________________--

CREATE OR REPLACE FUNCTION new_customer(
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  phone_number VARCHAR(30),
  email_address VARCHAR(50),
  address VARCHAR(50),
  payment VARCHAR(50))
RETURNS VOID AS
$$
BEGIN
  INSERT INTO customers ("first_name", "last_name", "phone_number", "email_address", "address", "payment")
  VALUES (first_name, last_name, phone_number, email_address, address, payment);
END;
$$
LANGUAGE plpgsql;
--
SELECT new_customer('August', 'Ames', '949-875-1918', 'august_ames@racing.com', '812 Superfast Lane', 'Bitcoin');
--
select *
from customers;
--
CREATE OR REPLACE FUNCTION new_inventory_car (
  price NUMERIC(10,2),
  model VARCHAR(30),
  new_car BOOLEAN,
  customer_id INTEGER)
RETURNS VOID AS
$$
BEGIN
  INSERT INTO car ("price", "model", "new_car", "customer_id")
  VALUES (price, model, new_car, customer_id);
END;
$$
LANGUAGE plpgsql;
--
SELECT new_inventory_car(1888000.00, 'Porsche 918 Spyder', TRUE, 1);
select *
from car;
--
CREATE OR REPLACE FUNCTION new_service(
  service_done VARCHAR(30),
  service_total NUMERIC(6,2),
  service_date DATE)
RETURNS VOID AS
$$
BEGIN
  INSERT INTO service_ticket (service_done, service_total, service_date)
  VALUES (service_done, service_total, service_date);
END;
$$
LANGUAGE plpgsql;
--
SELECT new_service('Twin Turbo Upgrade', 12000.00, '2024-02-02');
--
INSERT INTO "parts" ("part_name", "used_in_service") VALUES
('exhaust_kit', true),
('turbo_kit', true),
('cold_air_intake', true),
('suspension_kit', true),
('ecu_tuner', true),
('high_flow_injectors', true),
('lightweight_flywheel', true),
('performance_brakes', true),
('adjustable_coilovers', true),
('performance_cam', true);
--
CREATE OR REPLACE FUNCTION create_invoice_for_car(
  car_model VARCHAR(30),
  sales_staff_id INTEGER,
  invoice_date DATE
)
RETURNS VOID AS
$$
DECLARE
  car_id INTEGER;
BEGIN
  SELECT "car_id" INTO car_id
  FROM "car"
  WHERE "model" = car_model;
--
  INSERT INTO "invoice" ("invoice_date", "salesstaff_id", "car_id")
  VALUES (invoice_date, sales_staff_id, car_id);
END;
$$
LANGUAGE plpgsql;
--
CREATE OR REPLACE FUNCTION create_invoice_for_car(
  car_model VARCHAR(30),
  sales_staff_id INTEGER,
  invoice_date DATE
)
RETURNS VOID AS
$$
DECLARE
  car_id INTEGER;
BEGIN
  SELECT "car"."car_id" INTO car_id
  FROM "car"
  WHERE "car"."model" = car_model;
  INSERT INTO "invoice" ("invoice_date", "salesstaff_id", "car_id")
  VALUES (invoice_date, sales_staff_id, car_id);
END;
$$
LANGUAGE plpgsql;
--
SELECT create_invoice_for_car('Porsche 918 Spyder', 1, '2024-02-02');
--
INSERT INTO "invoice" ("invoice_date", "salesstaff_id", "car_id")
VALUES (invoice_date, sales_staff_id, car_id);
--
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'salesstaff_ids') THEN
    CREATE TYPE salesstaff_ids AS ENUM ('1', '2', '3', '4', '5', '6', '7');
  END IF;
END $$;
--
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'invoice_dates') THEN
    CREATE TYPE invoice_dates AS ENUM ('2023-03-15', '2023-05-22', '2023-07-08', '2023-09-14', '2023-10-30', '2023-04-18', '2023-06-27', '2023-08-09', '2023-11-12', '2023-12-20');
  END IF;
END $$;
--
DO $$ 
DECLARE
  customer_id INTEGER;
BEGIN
  FOR customer_id IN 1 TO 11 LOOP
    INSERT INTO car ("price", "model", "new_car", "customer_id", "salesstaff_id")
    VALUES (
      (RANDOM() * 100000)::NUMERIC(10,2),
      'Car Model ' || customer_id,
      TRUE,
      customer_id,
      salesstaff_ids[1 + (customer_id % 7)]::INTEGER
    );
--
    INSERT INTO invoice ("invoice_date", "salesstaff_id", "car_id")
    VALUES (
      invoice_dates[1 + (customer_id % 10)]::DATE,
      salesstaff_ids[1 + (customer_id % 7)]::INTEGER,
      customer_id
    );
  END LOOP;
END $$;

----------------------------------------------------------------------------------

UPDATE service_ticket
SET car_id = car.car_id,
    mec_id = mechanics.mec_id,
    customer_id = customers.customer_id,
    parts_used = parts.part_name
FROM car
JOIN mechanics ON service_ticket.mec_id = mechanics.mec_id
JOIN customers ON service_ticket.customer_id = customers.customer_id
LEFT JOIN parts ON service_ticket.parts_used = parts.part_name
WHERE service_ticket.car_id = car.car_id;

----------------------------------------------------------------------------------
SELECT * FROM service_ticket;

----------------------------------------------------------------------------------

UPDATE service_ticket
SET car_id = car.car_id,
    mec_id = mechanics.mec_id,
    customer_id = customers.customer_id,
    parts_used = parts.part_name
FROM car
JOIN mechanics ON service_ticket.mec_id = mechanics.mec_id
JOIN customers ON service_ticket.customer_id = customers.customer_id
LEFT JOIN parts ON service_ticket.parts_used = parts.part_name
WHERE service_ticket.car_id = car.car_id;

---------------------------------------------------------------------------------
SELECT * FROM service_ticket;

----------------------------------------------------------------------------------
SELECT
  car ."car_id",
  car."model",
  car."price",
  sales_staff."first_name" AS "salesperson_first_name",
  sales_staff."last_name" AS "salesperson_last_name"
FROM
  "car"
JOIN
  "invoice" ON car."car_id" = "invoice"."car_id"
JOIN
  "sales_staff" ON "invoice"."salesstaff_id" = sales_staff."salesstaff_id";
 
----------------------------------------------------------------------------------
SELECT
  sales_staff."salesstaff_id",
  sales_staff."first_name",
  sales_staff."last_name"
FROM
  "car"
JOIN
  "invoice" ON car."car_id" = "invoice"."car_id"
JOIN
  "sales_staff" ON "invoice"."salesstaff_id" = sales_staff."salesstaff_id"
WHERE
  car."model" = 'Porsche 918 Spyder';
---------------------------------------------------------------------------------- 

select *
from car;
select *
from customers;
select *
from invoice;
select *
from mechanics;
select *
from parts;
select *
from sales_staff;
select *
from service_ticket;
---------------------------------------------------------------------------------
SELECT
  service_ticket."service_ticket_id",
  service_ticket."service_done",
  service_ticket."service_total",
  service_ticket."service_date",
  mechanics."mec_id",
  car."car_id",
  car."model" AS "car_model",
  customers."customer_id",
  customers."first_name" AS "customer_first_name",
  customers."last_name" AS "customer_last_name",
  service_ticket."parts_used"
FROM
  "service_ticket"
JOIN
  "mechanics" ON service_ticket."mec_id" = mechanics."mec_id"
JOIN
  "car" ON service_ticket."car_id" = car."car_id"
JOIN
  "customers" ON service_ticket."customer_id" = customers."customer_id"
LEFT JOIN
  "parts" ON service_ticket."parts_used" = parts."part_name";
----------------------------------------------------------------------------------- 
UPDATE car
SET salesstaff_id = floor(random() * 7 + 1)::integer;
--
update invoice
set customer_id = floor(random() * 10 + 1)::integer;
--
UPDATE invoice
SET salesstaff_id = car.salesstaff_id
FROM car
WHERE invoice.car_id = car.car_id;
--
SELECT * FROM invoice;
--
SELECT
  st."service_ticket_id",
  st."service_done",
  st."service_total",
  st."service_date",
  m."mec_id",
  c."car_id",
  c."model" AS "car_model",
  cu."customer_id",
  cu."first_name" AS "customer_first_name",
  cu."last_name" AS "customer_last_name",
  st."parts_used"
FROM
  "service_ticket" st
JOIN
  "mechanics" m ON st."mec_id" = m."mec_id"
JOIN
  "car" c ON st."car_id" = c."car_id"
JOIN
  "customers" cu ON st."customer_id" = cu."customer_id"
LEFT JOIN
  "parts" p ON st."parts_used" = p."part_name";
 --
UPDATE "service_ticket" SET
  "customer_id" = (1 + (random() * 3))::INTEGER, 
  "mec_id" = (1 + (random() * 3))::INTEGER,        
  "car_id" = (1 + (random() * 3))::INTEGER,        
  "parts_used" = (
    CASE
      WHEN random() < 0.3 THEN 'Oil Filter'
      WHEN random() < 0.6 THEN 'Brake Pads'
      ELSE 'Spark Plugs'
    END
  )
WHERE "service_done" IS NULL;
--
SELECT
  "service_ticket_id",
  "service_done",
  "service_total",
  "service_date",
  "mec_id",
  "car_id",
  "customer_id",
  "parts_used"
FROM "service_ticket";
--
UPDATE "service_ticket" SET
"customer_id" = (1 + floor(random() * 3)),
"mec_id" = (1 + floor(random() * 3)),
"car_id" = (1 + floor(random() * 3)),
"parts_used" = CASE
WHEN random() < 0.33 THEN 'Oil Filter'
WHEN random() < 0.66 THEN 'Brake Pads'
ELSE 'Spark Plugs'
                 END;
  --              
SELECT
  service_ticket."service_ticket_id",
  service_ticket."service_done",
  service_ticket."service_total",
  service_ticket."service_date",
  mechanics."mec_id",
  car."car_id",
  car."model" AS "car_model",
  customers."customer_id",
  customers."first_name" AS "customer_first_name",
  customers."last_name" AS "customer_last_name",
  service_ticket."parts_used"
FROM
  "service_ticket"
JOIN
  "mechanics" ON service_ticket."mec_id" = mechanics."mec_id"
JOIN
  "car" ON service_ticket."car_id" = car."car_id"
JOIN
  "customers" ON service_ticket."customer_id" = customers."customer_id"
LEFT JOIN
  "parts" ON service_ticket."parts_used" = parts."part_name";
 --
 SELECT new_customer('Chris', 'Hemsworth', '949-232-7750', 'chris_hemsworth@thor.com', '989 God of Thunder Road', 'Mastercard');
--__________________________________________________________________________________________________________________________________________________--
--1. A salesperson may sell many cars, but each car is sold by only one salesperson.
--
--The sales_staff table represents salespersons.
--The car table has a foreign key salesstaff_id which references the salesperson who sold the car.
--This relationship ensures that each car is sold by only one salesperson.
--__________________________________________________________________________________________________________________________________________________--
--2. A customer may buy many cars, but each car is purchased by only one customer.
--
--The customers table represents customers.
--The car table has a foreign key customer_id which references the customer who purchased the car.
--This relationship ensures that each car is purchased by only one customer.
--__________________________________________________________________________________________________________________________________________________--
--3. A salesperson writes a single invoice for each car they sell.
--
--The invoice table contains invoices, and it has a foreign key salesstaff_id referencing the salesperson who wrote the invoice.
--Each row in the invoice table is associated with a specific car through the foreign key car_id.
--__________________________________________________________________________________________________________________________________________________--
--4. A customer gets an invoice for each car they buy.
--
--The invoice table has a foreign key customer_id referencing the customer who receives the invoice.
--Each row in the invoice table is associated with a specific car through the foreign key car_id.
--__________________________________________________________________________________________________________________________________________________--
--5. A customer may come in just to have their car serviced; that is, a customer need not buy a car to be classified as a customer.
--
--The service_ticket table has a foreign key customer_id referencing the customer who brings the car for service.
--This allows customers to be associated with service tickets even if they haven't bought a car.
--__________________________________________________________________________________________________________________________________________________--
--6. When a customer takes one or more cars in for repair or service, one service ticket is written for each car.
--
--The service_ticket table records individual service tickets, and each ticket is associated with a specific car through the foreign key car_id.
--Multiple service tickets can be created for different cars brought in by the same customer.
--__________________________________________________________________________________________________________________________________________________--
--7. The car dealership maintains a service history for each of the cars serviced. The service records are referenced by the car’s serial number.
--
--The service_ticket table records service history for each car through the foreign key car_id.
--Each service ticket is associated with a specific car, and you can retrieve the service history based on the car's serial number.
--__________________________________________________________________________________________________________________________________________________--
--8. A car brought in for service can be worked on by many mechanics, and each mechanic may work on many cars.
--
--The service_ticket table has a foreign key mec_id referencing the mechanic who worked on the service ticket.
--This allows multiple service tickets to reference the same mechanic, fulfilling the many-to-many relationship.
--__________________________________________________________________________________________________________________________________________________--
--9. A car that is serviced may or may not need parts (e.g., adjusting a carburetor or cleaning a fuel injector nozzle does not require 
--providing new parts).
--
--The service_ticket table includes a column parts_used (changed to VARCHAR) where you can store information about the parts used during the service.
--__________________________________________________________________________________________________________________________________________________--

--Additional Requirements: 

ALTER TABLE car
ADD COLUMN is_serviced BOOLEAN DEFAULT FALSE;

CREATE OR REPLACE PROCEDURE serviced(serviced_car_id INTEGER)
AS
$$
BEGIN
    IF EXISTS (SELECT 1 FROM car WHERE car_id = serviced_car_id AND is_serviced = FALSE) then
        UPDATE car SET is_serviced = TRUE WHERE car_id = serviced_car_id;
        RAISE NOTICE 'Service Updated for car_id %', serviced_car_id;
    ELSE
        RAISE NOTICE 'Car car_id % is Serviced', serviced_car_id;
    END IF;
END;
$$ LANGUAGE plpgsql;

CALL serviced(8);

select *
from car;

select *
from car
order by car_id;


