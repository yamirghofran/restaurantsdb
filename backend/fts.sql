-- Add fulltext indexes
ALTER TABLE menu_menuitem ADD FULLTEXT INDEX menu_item_search (name, description);
ALTER TABLE menu_restaurant ADD FULLTEXT INDEX restaurant_search (name, address, cuisine_type);

-- To remove if needed:
-- ALTER TABLE menu_menuitem DROP INDEX menu_item_search;
-- ALTER TABLE menu_restaurant DROP INDEX restaurant_search;