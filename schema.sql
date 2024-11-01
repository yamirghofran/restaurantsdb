-- Create the database
CREATE DATABASE IF NOT EXISTS restaurantdb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE restaurantdb;

-- Start transaction
START TRANSACTION;

-- Drop existing tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS menu_statistics_mv;
DROP TABLE IF EXISTS search_index;
DROP TABLE IF EXISTS processing_logs;
DROP TABLE IF EXISTS item_dietary_restrictions;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS dietary_restrictions;
DROP TABLE IF EXISTS menu_sections;
DROP TABLE IF EXISTS menu_versions;
DROP TABLE IF EXISTS restaurants;

-- Drop triggers if they exist
DROP TRIGGER IF EXISTS after_menu_item_change;
DROP TRIGGER IF EXISTS before_menu_version_current;
DROP TRIGGER IF EXISTS after_menu_item_stats;

-- Create tables
CREATE TABLE restaurants (
    restaurant_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    website VARCHAR(255),
    cuisine_type VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_restaurant_name (name),
    INDEX idx_cuisine_type (cuisine_type),
    FULLTEXT INDEX ft_restaurant_search (name, cuisine_type, address)
) ENGINE=InnoDB;

CREATE TABLE menu_versions (
    version_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT UNSIGNED NOT NULL,
    version_number INT NOT NULL,
    effective_date DATE NOT NULL,
    source_type ENUM('upload', 'scrape', 'manual') NOT NULL,
    source_url TEXT,
    is_current BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    UNIQUE INDEX idx_restaurant_version (restaurant_id, version_number),
    INDEX idx_effective_date (effective_date)
) ENGINE=InnoDB;

CREATE TABLE menu_sections (
    section_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    version_id INT UNSIGNED NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    display_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (version_id) REFERENCES menu_versions(version_id) ON DELETE CASCADE,
    INDEX idx_version_order (version_id, display_order),
    FULLTEXT INDEX ft_section_search (name, description)
) ENGINE=InnoDB;

CREATE TABLE dietary_restrictions (
    restriction_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    icon_url VARCHAR(255),
    UNIQUE INDEX idx_restriction_name (name)
) ENGINE=InnoDB;

CREATE TABLE menu_items (
    item_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    section_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    calories INT,
    spice_level TINYINT,
    is_available BOOLEAN DEFAULT TRUE,
    display_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (section_id) REFERENCES menu_sections(section_id) ON DELETE CASCADE,
    INDEX idx_section_order (section_id, display_order),
    INDEX idx_item_name (name),
    INDEX idx_price_range (price),
    INDEX idx_availability (is_available),
    INDEX idx_spice_level (spice_level),
    FULLTEXT INDEX ft_item_search (name, description)
) ENGINE=InnoDB;

CREATE TABLE item_dietary_restrictions (
    item_id INT UNSIGNED NOT NULL,
    restriction_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (item_id, restriction_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (restriction_id) REFERENCES dietary_restrictions(restriction_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE processing_logs (
    log_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    version_id INT UNSIGNED NOT NULL,
    process_type ENUM('upload', 'scrape', 'ai_processing', 'validation') NOT NULL,
    status ENUM('started', 'completed', 'failed') NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    error_message TEXT,
    metadata JSON,
    FOREIGN KEY (version_id) REFERENCES menu_versions(version_id) ON DELETE CASCADE,
    INDEX idx_version_status (version_id, status),
    INDEX idx_start_time (start_time)
) ENGINE=InnoDB;

CREATE TABLE menu_statistics_mv (
    restaurant_id INT UNSIGNED PRIMARY KEY,
    total_items INT,
    avg_price DECIMAL(10,2),
    vegetarian_count INT,
    vegan_count INT,
    gluten_free_count INT,
    last_updated TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE search_index (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    entity_type ENUM('restaurant', 'menu_item', 'section') NOT NULL,
    entity_id INT UNSIGNED NOT NULL,
    content TEXT NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FULLTEXT INDEX ft_content(content),
    UNIQUE INDEX idx_entity (entity_type, entity_id)
) ENGINE=InnoDB;

-- Create triggers
DELIMITER //

CREATE TRIGGER after_menu_item_change
AFTER INSERT ON menu_items
FOR EACH ROW
BEGIN
    INSERT INTO search_index (entity_type, entity_id, content)
    VALUES ('menu_item', NEW.item_id, 
            CONCAT(NEW.name, ' ', COALESCE(NEW.description, '')))
    ON DUPLICATE KEY UPDATE
        content = VALUES(content);
END//

CREATE TRIGGER before_menu_version_current
BEFORE UPDATE ON menu_versions
FOR EACH ROW
BEGIN
    IF NEW.is_current = TRUE THEN
        UPDATE menu_versions
        SET is_current = FALSE
        WHERE restaurant_id = NEW.restaurant_id
        AND version_id != NEW.version_id;
    END IF;
END//

CREATE TRIGGER after_menu_item_stats
AFTER INSERT ON menu_items
FOR EACH ROW
BEGIN
    INSERT INTO menu_statistics_mv (
        restaurant_id,
        total_items,
        avg_price,
        last_updated
    )
    SELECT 
        mv.restaurant_id,
        COUNT(*),
        AVG(mi.price),
        CURRENT_TIMESTAMP
    FROM menu_items mi
    JOIN menu_sections ms ON mi.section_id = ms.section_id
    JOIN menu_versions mv ON ms.version_id = mv.version_id
    WHERE mv.is_current = TRUE
    GROUP BY mv.restaurant_id
    ON DUPLICATE KEY UPDATE
        total_items = VALUES(total_items),
        avg_price = VALUES(avg_price),
        last_updated = CURRENT_TIMESTAMP;
END//

DELIMITER ;

-- Commit the transaction
COMMIT;

-- Verify the schema
SHOW TABLES;
-- Error handling
-- If you need to rollback:
-- ROLLBACK;
