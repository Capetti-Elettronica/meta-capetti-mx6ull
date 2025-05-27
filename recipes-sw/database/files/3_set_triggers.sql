-- Triggers Migration
-- 
-- It defines all the events that can be automatically managed by sqlite
-- without any further intervention from the driver.

-- update user updated_at datetime
CREATE TRIGGER set_user_updated_at AFTER UPDATE ON user
BEGIN
    UPDATE user SET updated_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
END;

-- update bs updated_at datetime
CREATE TRIGGER set_bs_updated_at AFTER UPDATE ON bs
BEGIN
    UPDATE bs SET updated_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
END;

-- update bs diagnostic updated_at datetime
CREATE TRIGGER set_bs_diag_updated_at AFTER UPDATE ON bs_diag
BEGIN
    UPDATE bs_diag SET updated_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
END;

-- update sensor updated_at datetime
CREATE TRIGGER set_sensor_updated_at AFTER UPDATE ON sensor
BEGIN
    UPDATE sensor SET updated_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
END;

-- update sensor diagnostic updated_at datetime
CREATE TRIGGER set_sensor_diag_updated_at AFTER UPDATE ON sensor_diag
BEGIN
    UPDATE sensor_diag SET updated_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
END;

-- update cloud connection end datetime
CREATE TRIGGER set_cloud_connection_end AFTER UPDATE ON cloud
BEGIN
    UPDATE cloud SET connection_end = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
END;

-- update settings modified_at datetime
CREATE TRIGGER set_settings_modified_at AFTER UPDATE ON settings
BEGIN
    UPDATE settings SET modified_at = CURRENT_TIMESTAMP WHERE rowid = NEW.rowid;
END;