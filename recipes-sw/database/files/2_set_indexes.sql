-- bs diag indexes
CREATE INDEX IF NOT EXISTS idx_bs_diag_bs_id ON bs_diag (bs_id);

-- sensor indexes
CREATE UNIQUE INDEX IF NOT EXISTS idx_mac_address ON sensor(mac_address);
CREATE UNIQUE INDEX IF NOT EXISTS sensor_net_id_key ON sensor(net_id);
CREATE INDEX IF NOT EXISTS idx_sensor_bs_id ON sensor (bs_id);
CREATE INDEX IF NOT EXISTS idx_sensor_pending ON sensor(pending);

-- sensor diag indexes
CREATE INDEX IF NOT EXISTS idx_sensor_diag_sensor_id ON sensor_diag (sensor_owner_id);

-- channel indexes
CREATE INDEX IF NOT EXISTS idx_channel_sensor_id ON channel (sensor_owner_id);
CREATE INDEX IF NOT EXISTS idx_channel_ch_number ON channel (ch_number);

-- measure indexes
CREATE INDEX IF NOT EXISTS idx_measure_evt_timestamp_sensor_id ON measure_evt (sensor_owner_id, timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_measure_val_timestamp_channel_id_sensor_id ON measure_val (sensor_owner_id, channel_id, timestamp DESC);

-- cloud indexes
CREATE INDEX IF NOT EXISTS idx_cloud_connection_start ON cloud (connection_start);
CREATE INDEX IF NOT EXISTS idx_cloud_connection_end ON cloud (connection_end);
CREATE INDEX IF NOT EXISTS idx_cloud_result ON cloud (result);

-- settings indexes
CREATE INDEX IF NOT EXISTS idx_settings_name ON settings (name);
