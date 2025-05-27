-- these values must be used only in read mode from standard users
-- values are modifiable only in production or from a master user
INSERT INTO "gateway" (name, data_type, default_value, value)
VALUES
    ('Part Number', 'String', 'Linux Gateway', 'LNX GW'),
    ('Serial Number', 'String', '123456', '123456'),
    ('Mac Address', 'String', '1984DADE', '1984DADE'),
    ('Version', 'String', '1.0.0', '1.0.0'),
    ('Release Candidate', 'Bool', 'false', 'true'),
    ('Release Candidate Version', 'String', '', 'R1'),
    ('Special Product', 'Bool', 'false', 'true'),
    ('Special Product Version', 'String', '', 'M1'),
    ('Linux Console', 'String', 'ttymxc0', 'ttymxc0'),
    ('Internal Port', 'String', 'ttymxc3', 'ttymxc3'),
    ('RS-232 Port', 'String', 'ttymxc4', 'ttymxc4'),
    ('RS-485 Port', 'String', 'ttymxc1', 'ttymxc1'),
    ('Bluetooth Port', 'String', 'ttymxc7', 'ttymxc7'),
    ('Modem AT Cmd Port', 'String', 'ttyUSB3', 'ttyUSB3'),
    ('LoRa USB Port', 'String', 'ttyUSB10', 'ttyUSB10'),    -- this must be set from a script
    ('LuPo USB Port', 'String', 'ttyUSB11', 'ttyUSB11'),    -- this must be set from a script
    ('Last Meas Event Sync', 'Int', '0', '0'),
    ('Last Meas Value Sync', 'Int', '0', '0');