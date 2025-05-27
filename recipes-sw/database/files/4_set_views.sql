CREATE VIEW sensor_list_view AS
SELECT 
    s.bs_id,
    s.net_id,
    s.mac_address,
    s.name,
    s.meas_interval,
    s.sample_interval,
    s.standby,
    s.routing,
    e.timestamp,
    e.rssi,
    e.dev_sts,
    e.sensor_parent_id,
    c.ch_number,
    c.ch_type,
    c.meas_offset,
    c.meas_gain,
	v.value,
	v.channel_sts,
	v.level_sts
FROM 
    sensor s
LEFT JOIN measure_evt e 
    ON s.sensor_id = e.sensor_owner_id 
    AND e.timestamp = (
        SELECT MAX(timestamp) 
        FROM measure_evt 
        WHERE sensor_owner_id = s.sensor_id
    )
LEFT JOIN channel c 
    ON s.sensor_id = c.sensor_owner_id
LEFT JOIN measure_val v
	ON s.sensor_id = v.sensor_owner_id 
	AND c.ch_number = v.channel_id
	AND v.timestamp = (
		SELECT MAX(timestamp)
		FROM measure_val
		WHERE sensor_owner_id = v.sensor_owner_id
        AND channel_id = v.channel_id
	);

CREATE VIEW measure_list_view AS
SELECT 
    e.sensor_owner_id,
    e.timestamp,
    e.rssi,
    e.dev_sts,
    e.sensor_parent_id,
    c.ch_number,
    c.ch_type,
    c.meas_offset,
    c.meas_gain,
	v.value,
	v.channel_sts,
	v.level_sts
FROM 
    measure_evt e
LEFT JOIN channel c 
    ON e.sensor_owner_id = c.sensor_owner_id
LEFT JOIN measure_val v
	ON e.sensor_owner_id = v.sensor_owner_id 
	AND c.ch_number = v.channel_id
    AND v.timestamp = e.timestamp;
