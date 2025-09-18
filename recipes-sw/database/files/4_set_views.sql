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
    s.last_ts,
    s.last_rssi,
    s.last_dev_sts,
    s.last_parent_id,
    c.ch_number,
    c.ch_type,
    c.meas_offset,
    c.meas_gain,
	  c.last_value,
	  c.last_ch_sts,
	  c.last_lvl_sts
FROM
    sensor s
LEFT JOIN channel c
    ON s.sensor_id = c.sensor_owner_id;

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

CREATE VIEW IF NOT EXISTS pending_measure_list_view AS
SELECT
    e.evt_id,
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
FROM pending_evt p
JOIN measure_evt e
    ON p.evt_id = e.evt_id
LEFT JOIN channel c
    ON e.sensor_owner_id = c.sensor_owner_id
LEFT JOIN measure_val v
    ON e.sensor_owner_id = v.sensor_owner_id
   AND c.ch_number = v.channel_id
   AND v.timestamp = e.timestamp;
