-- these values are in default mode, users can modify them and eventually
-- restore default parameter through future reset procedures
INSERT INTO "user" (username, password, roles)
VALUES
    ('demo', '$2b$12$YItTbXc.jy3WA0JGWgoFGeOPqkmImkApu0r3X4sKy1QMYZYkwMxtC', 1),
    ('standard', '$2b$12$ODK9E8PjFy7Xnob.9/Yl0uWG/PvgWtlt.GwL2KL9eQvsCkqXMcuZi', 3),
    ('capmaster', '$2b$12$hUQOHpEPxxRshDM9LAMA9u38l/u/yGnvKm2EZVJgnTeKUi3Q/LJLK', 255);
