-- Tables Migration
--
-- It defines all the basic schema based on what actually stored on other gateways
-- Please remind to run sqlite_setup.py before in order to apply all PRAGMA_CONFIGS

-- user schema
CREATE TABLE IF NOT EXISTS "user" (
    "created_at" INTEGER DEFAULT (strftime('%s','now')),
    "updated_at" INTEGER,
    "accessed_at" INTEGER,
    "username" TEXT PRIMARY KEY,
    "password" TEXT NOT NULL,
    "roles" INTEGER NOT NULL DEFAULT 1
);

-- gateway schema
CREATE TABLE IF NOT EXISTS "gateway" (
    "name" TEXT PRIMARY KEY COLLATE NOCASE,
    "data_type" TEXT CHECK(data_type IN ('Bool', 'Int', 'Float', 'String')),
    "default_value" TEXT,
    "value" TEXT,
    "created_at" INTEGER DEFAULT (strftime('%s','now')),
    "modified_at" INTEGER
);

-- basestation schema
CREATE TABLE IF NOT EXISTS "bs" (
    "enrolled_at" INTEGER DEFAULT (strftime('%s','now')),
    "updated_at" INTEGER,
    "network_key" TEXT COLLATE NOCASE,
    "device_name" TEXT COLLATE NOCASE,
    "serial_addr" INTEGER NOT NULL,
    "wine_addr" INTEGER PRIMARY KEY,
    "media" TEXT NOT NULL,
    "tty_port" TEXT NOT NULL,
    "radio_type" TEXT NOT NULL COLLATE NOCASE,
    "radio_mod" TEXT NOT NULL COLLATE NOCASE,
    "fw_ver" TEXT NOT NULL,
    "enabled" INTEGER NOT NULL,
    "enroll_state" INTEGER NOT NULL,
    "enroll_addr" INTEGER
);

-- basestation diagnostic data schema
CREATE TABLE IF NOT EXISTS "bs_diag" (
    "bs_diag_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "created_at" INTEGER DEFAULT (strftime('%s','now')),
    "updated_at" INTEGER,
    "bs_id" INTEGER NOT NULL COLLATE NOCASE,
    "avg_tx_time" INTEGER NOT NULL,
    "reset_count" INTEGER NOT NULL,
    "reset_cause" INTEGER NOT NULL,
    "rtc_sync" INTEGER NOT NULL,
    "uptime"  INTEGER NOT NULL,
    CONSTRAINT "diag_bs_id_fkey" FOREIGN KEY ("bs_diag_id")
    REFERENCES "Bs" ("wine_addr") ON DELETE CASCADE ON UPDATE CASCADE
);

-- sensor schema
CREATE TABLE IF NOT EXISTS "sensor" (
    "sensor_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "enrolled_at" INTEGER DEFAULT (strftime('%s','now')),
    "updated_at" INTEGER,
    "net_id" INTEGER UNIQUE NOT NULL,
    "mac_address" TEXT NOT NULL UNIQUE COLLATE NOCASE,
    "bs_id" INTEGER NOT NULL,
    "name" TEXT COLLATE NOCASE,
    "notes" TEXT,
    "meas_interval" INTEGER,
    "sample_interval" INTEGER,
    "standby" INTEGER NOT NULL,
    "forced_utc" INTEGER NOT NULL,
    "test" INTEGER NOT NULL,
    "routing" INTEGER NOT NULL,
    "force_config" INTEGER NOT NULL,
    "info_extended" INTEGER NOT NULL,
    "tamper_enable" INTEGER NOT NULL,
    "tamper_polarity" INTEGER NOT NULL,
    "dev_type" TEXT COLLATE NOCASE,
    "dev_sn" TEXT COLLATE NOCASE,
    "sensor_fw" INTEGER,
    "radio_fw" INTEGER,
    "channels_num" INTEGER NOT NULL,
    "last_ts" INTEGER,
    "last_rssi" INTEGER,
    "last_dev_sts" INTEGER,
    "last_parent_id" INTEGER,
    "pending" INTEGER NOT NULL,
    CONSTRAINT "sensor_bs_id_fkey" FOREIGN KEY ("bs_id")
    REFERENCES "Bs" ("wine_addr") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- sensor diagnostica data schema
CREATE TABLE IF NOT EXISTS "sensor_diag" (
    "sensor_diag_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "created_at" INTEGER DEFAULT (strftime('%s','now')),
    "updated_at" INTEGER,
    "sensor_owner_id" INTEGER NOT NULL,
    "avg_tx_time" INTEGER NOT NULL,
    "bs_sync" INTEGER NOT NULL,
    "bs_change" INTEGER NOT NULL,
    "reset" INTEGER NOT NULL,
    "nack_radio" INTEGER NOT NULL,
    "retries" INTEGER NOT NULL,
    "rtc_sync" INTEGER NOT NULL,
    "uptime" INTEGER NOT NULL,
    "idle_time" INTEGER NOT NULL,
    "wake_time" INTEGER NOT NULL,
    "rx_time" INTEGER NOT NULL,
    "tx_time" INTEGER NOT NULL,
    "tx_ack" INTEGER NOT NULL,
    "tx_nack" INTEGER NOT NULL,
    "tx_sync" INTEGER NOT NULL,
    "rx_ok" INTEGER NOT NULL,
    "rx_err" INTEGER NOT NULL,
    "slot" INTEGER NOT NULL,
    "slot_timeout" INTEGER NOT NULL,
    CONSTRAINT "diag_sensor_id_fkey" FOREIGN KEY ("sensor_owner_id")
    REFERENCES "Sensor" ("sensor_id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- sensor channel schema
CREATE TABLE IF NOT EXISTS "channel" (
    "ch_number" INTEGER NOT NULL,
    "sensor_owner_id" INTEGER NOT NULL,
    "name" TEXT COLLATE NOCASE,
    "ch_type" INTEGER NOT NULL,
    "ch_bytes" INTEGER NOT NULL,
    -- "ch_subseconds" INTEGER, -- could be useful for new zcap-ora
    "ch_enable" INTEGER NOT NULL,
    "ch_write" INTEGER NOT NULL,
    "follow_av" INTEGER NOT NULL,
    "follow_en" INTEGER NOT NULL,
    "threshold_mode" INTEGER NOT NULL,
    "threshold2_en" INTEGER NOT NULL,
    "threshold2_type" INTEGER NOT NULL,
    "threshold1_en" INTEGER NOT NULL,
    "threshold1_type" INTEGER NOT NULL,
    "threshold1" INTEGER NOT NULL,
    "threshold2" INTEGER NOT NULL,
    "meas_offset" INTEGER NOT NULL,
    "meas_gain" REAL NOT NULL,
    "meas_interval" INTEGER,
    "sample_interval" INTEGER,
    --"threshold_av" INTEGER, -- could be useful for new zcap-ora
    "follow_up" INTEGER,
    "follow_down" INTEGER,
    "last_value" INTEGER,
    "last_ch_sts" INTEGER,
    "last_lvl_sts" INTEGER,
    PRIMARY KEY ("ch_number", "sensor_owner_id"),
    CONSTRAINT "channel_sensor_id_fkey" FOREIGN KEY ("sensor_owner_id")
    REFERENCES "sensor" ("sensor_id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS "measure_evt" (
    "evt_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "timestamp" INTEGER NOT NULL,
    "rssi" INTEGER NOT NULL,
    "dev_sts" INTEGER NOT NULL,
    "sensor_owner_id" INTEGER NOT NULL,     -- sensor unique id to retrieve event and data
    "sensor_parent_id" INTEGER,             -- sensor parent id to create topography chart
    CONSTRAINT "unique_timestamp_sensor" UNIQUE ("timestamp", "sensor_owner_id")
    CONSTRAINT "measure_evt_sensor_id_fkey" FOREIGN KEY ("sensor_owner_id")
    REFERENCES "sensor" ("sensor_id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS "measure_val" (
    "meas_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "timestamp" INTEGER NOT NULL,
    "value" INTEGER NOT NULL,
    "channel_id" INTEGER NOT NULL,
    "channel_sts" INTEGER NOT NULL,
    "level_sts" INTEGER NOT NULL,
    "sensor_owner_id" INTEGER NOT NULL,
    CONSTRAINT "unique_timestamp_sensor_channel" UNIQUE ("timestamp", "sensor_owner_id", "channel_id")
    CONSTRAINT "measure_val_measure_evt_fkey" FOREIGN KEY ("timestamp", "sensor_owner_id")
    REFERENCES "measure_evt" ("timestamp", "sensor_owner_id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS "pending_evt" (
    "evt_id" INTEGER PRIMARY KEY,
    FOREIGN KEY ("evt_id") REFERENCES "measure_evt" ("evt_id") ON DELETE CASCADE
);

-- cloud connections schema
CREATE TABLE IF NOT EXISTS "cloud" (
    "cloud_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "connection_start" INTEGER DEFAULT (strftime('%s','now')),
    "connection_end" INTEGER,
    "signal_quality" INTEGER NOT NULL,
    "supply_voltage" INTEGER NOT NULL,
    "result" TEXT COLLATE NOCASE
);

-- settings schema
CREATE TABLE IF NOT EXISTS "settings" (
    "name" TEXT PRIMARY KEY COLLATE NOCASE,
    "data_type" TEXT CHECK(data_type IN ('Bool', 'Int', 'Float', 'String')),
    "default_value" TEXT,
    "value" TEXT,
    "created_at" INTEGER DEFAULT (strftime('%s','now')),
    "modified_at" INTEGER
);
