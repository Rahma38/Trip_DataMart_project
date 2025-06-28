CREATE TABLE dim_time (
    time_key INTEGER PRIMARY KEY,
    time_value VARCHAR(10) NOT NULL,
    hour INTEGER NOT NULL CHECK (hour BETWEEN 0 AND 23),
    minute INTEGER NOT NULL CHECK (minute BETWEEN 0 AND 59),
    second INTEGER NOT NULL CHECK (second BETWEEN 0 AND 59),
    am_pm CHAR(2) NOT NULL CHECK (am_pm IN ('AM', 'PM')),
    CONSTRAINT unique_time_value UNIQUE (time_value)
);

CREATE INDEX idx_dim_time_value ON dim_time(time_value);




CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_of_week VARCHAR(9) NOT NULL,
    day_number INTEGER NOT NULL CHECK (day_number BETWEEN 1 AND 31),
    month VARCHAR(9) NOT NULL,
    month_number INTEGER NOT NULL CHECK (month_number BETWEEN 1 AND 12),
    quarter INTEGER NOT NULL CHECK (quarter BETWEEN 1 AND 4),
    year INTEGER NOT NULL,
    is_weekend BOOLEAN NOT NULL
);

CREATE INDEX idx_dim_date_full_date ON dim_date(full_date);



CREATE TABLE dim_bus (
    bus_key SERIAL PRIMARY KEY,
    bus_id VARCHAR(20) NOT NULL,
    bus_code VARCHAR(200) NOT NULL,
    bus_frequency VARCHAR(20),
    agency_name VARCHAR(100),
    assigned_to VARCHAR(100),
    driver_id VARCHAR(20),
    route_id VARCHAR(200) NOT NULL,
    route_short_name VARCHAR(20) NOT NULL,
    start_stop VARCHAR(60) NOT NULL,
    end_stop VARCHAR(60) NOT NULL,
    effective_date DATE NOT NULL DEFAULT CURRENT_DATE,
    end_date DATE DEFAULT '9999-12-31',
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    checksum VARCHAR(100),
    CONSTRAINT unique_bus_route_current UNIQUE (bus_id, route_id, is_current)
);

CREATE INDEX idx_dim_bus_route_bus_id ON dim_bus(bus_id);
CREATE INDEX idx_dim_bus_route_route_id ON dim_bus(route_id);
CREATE INDEX idx_dim_bus_route_current ON dim_bus(bus_id, route_id, is_current);
CREATE INDEX idx_dim_bus_route_effective ON dim_bus(effective_date);
CREATE INDEX idx_dim_bus_route_checksum ON dim_bus(checksum);
CREATE INDEX idx_dim_bus_route_driver ON dim_bus(driver_id);



CREATE TABLE dim_driver (
    driver_key SERIAL PRIMARY KEY,
    driver_id VARCHAR(20) NOT NULL,     
    driver_username VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    hire_date DATE,
    contact_number VARCHAR(20),
    email VARCHAR(100), 
    effective_date DATE NOT NULL DEFAULT CURRENT_DATE,  
    end_date DATE DEFAULT '9999-12-31',                 
    is_current BOOLEAN NOT NULL DEFAULT TRUE,           
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    checksum VARCHAR(100)  
);

CREATE INDEX idx_dim_driver_id ON dim_driver(driver_id);
CREATE INDEX idx_dim_driver_current ON dim_driver(driver_id, is_current);
CREATE INDEX idx_dim_driver_effective ON dim_driver(effective_date);
CREATE INDEX idx_dim_driver_checksum ON dim_driver(checksum);





CREATE TABLE fact_trips (
    trip_key SERIAL PRIMARY KEY,
    driver_key INTEGER NOT NULL REFERENCES dim_driver(driver_key),
    bus_key INTEGER NOT NULL REFERENCES dim_bus(bus_key),
    date_key INTEGER NOT NULL REFERENCES dim_date(date_key),
    time_key INTEGER NOT NULL REFERENCES dim_time(time_key),
    duration INTEGER NOT NULL CHECK (duration > 0),
    distance_covered DECIMAL(10,2) NOT NULL CHECK (distance_covered > 0),
    is_completed BOOLEAN NOT NULL,
    duration_category VARCHAR(20) NOT NULL
);

CREATE INDEX idx_fact_trips_driver ON fact_trips(driver_key);
CREATE INDEX idx_fact_trips_bus_route ON fact_trips(bus_key);
CREATE INDEX idx_fact_trips_date ON fact_trips(date_key);
CREATE INDEX idx_fact_trips_time ON fact_trips(time_key);
CREATE INDEX idx_fact_trips_completed ON fact_trips(is_completed);