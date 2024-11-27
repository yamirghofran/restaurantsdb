-- Drop existing if needed (careful in production)
DROP TRIGGER IF EXISTS update_menu_statistics_insert;
DROP TRIGGER IF EXISTS update_menu_statistics_update;
DROP TRIGGER IF EXISTS update_menu_statistics_delete;
DROP VIEW IF EXISTS v_menu_statistics;
DROP TABLE IF EXISTS menu_menustatistics;

-- Create stats table
CREATE TABLE menu_menustatistics (
    restaurant_id BIGINT PRIMARY KEY,
    total_items INT DEFAULT 0,
    avg_price DECIMAL(10,2) DEFAULT 0.00,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES menu_restaurant(id) ON DELETE CASCADE
);

-- Create the view
CREATE VIEW v_menu_statistics AS
SELECT 
    r.id as restaurant_id,
    COUNT(DISTINCT mi.id) as total_items,
    COALESCE(AVG(mi.price), 0) as avg_price,
    NOW() as last_updated
FROM menu_restaurant r
LEFT JOIN menu_menuversion mv ON mv.restaurant_id = r.id AND mv.is_current = TRUE
LEFT JOIN menu_menusection ms ON ms.version_id = mv.id
LEFT JOIN menu_menuitem mi ON mi.section_id = ms.id
GROUP BY r.id;

-- Create the trigger
DELIMITER //
CREATE TRIGGER update_menu_statistics_insert
AFTER INSERT ON menu_menuitem
FOR EACH ROW
BEGIN
    INSERT INTO menu_menustatistics (
        restaurant_id, 
        total_items,
        avg_price,
        last_updated
    )
    SELECT * FROM v_menu_statistics 
    WHERE restaurant_id = (
        SELECT mv.restaurant_id
        FROM menu_menuversion mv
        JOIN menu_menusection ms ON ms.version_id = mv.id
        WHERE ms.id = NEW.section_id
    )
    ON DUPLICATE KEY UPDATE
        total_items = VALUES(total_items),
        avg_price = VALUES(avg_price),
        last_updated = NOW();
END//

CREATE TRIGGER update_menu_statistics_update
AFTER UPDATE ON menu_menuitem
FOR EACH ROW
BEGIN
    INSERT INTO menu_menustatistics (
        restaurant_id, 
        total_items,
        avg_price,
        last_updated
    )
    SELECT * FROM v_menu_statistics 
    WHERE restaurant_id = (
        SELECT mv.restaurant_id
        FROM menu_menuversion mv
        JOIN menu_menusection ms ON ms.version_id = mv.id
        WHERE ms.id = NEW.section_id
    )
    ON DUPLICATE KEY UPDATE
        total_items = VALUES(total_items),
        avg_price = VALUES(avg_price),
        last_updated = NOW();
END//

CREATE TRIGGER update_menu_statistics_delete
AFTER DELETE ON menu_menuitem
FOR EACH ROW
BEGIN
    INSERT INTO menu_menustatistics (
        restaurant_id, 
        total_items,
        avg_price,
        last_updated
    )
    SELECT * FROM v_menu_statistics 
    WHERE restaurant_id = (
        SELECT mv.restaurant_id
        FROM menu_menuversion mv
        JOIN menu_menusection ms ON ms.version_id = mv.id
        WHERE ms.id = OLD.section_id
    )
    ON DUPLICATE KEY UPDATE
        total_items = VALUES(total_items),
        avg_price = VALUES(avg_price),
        last_updated = NOW();
END//
DELIMITER ;

-- Initialize the stats
INSERT INTO menu_menustatistics (restaurant_id, total_items, avg_price, last_updated)
SELECT * FROM v_menu_statistics
ON DUPLICATE KEY UPDATE
    total_items = VALUES(total_items),
    avg_price = VALUES(avg_price),
    last_updated = NOW();