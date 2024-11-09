export interface Restaurant {
  id: number;
  name: string;
  address: string | null;
  phone: string | null;
  website: string | null;
  cuisine_type: string | null;
  created_at: string;
  updated_at: string;
  is_active: boolean;
  current_menu: MenuVersion | null;
  statistics: MenuStatistics | null;
}

export interface MenuVersion {
  id: number;
  restaurant_id: number;
  version_number: number;
  effective_date: string;
  source_type: 'upload' | 'scrape' | 'manual';
  source_url: string | null;
  is_current: boolean;
  created_at: string;
  sections: MenuSection[];
}

export interface MenuSection {
  id: number;
  name: string;
  description: string | null;
  display_order: number;
  created_at: string;
  menu_items: MenuItem[];
}

export interface MenuItem {
  id: number;
  name: string;
  description: string | null;
  price: number;
  currency: string;
  calories: number | null;
  spice_level: number | null;
  is_available: boolean;
  display_order: number;
  dietary_restrictions: DietaryRestriction[];
  created_at: string;
}

export interface DietaryRestriction {
  id: number;
  name: string;
  description: string | null;
  icon_url: string | null;
}

export interface MenuStatistics {
  restaurant_id: number;
  total_items: number | null;
  avg_price: number | null;
  vegetarian_count: number | null;
  vegan_count: number | null;
  gluten_free_count: number | null;
  last_updated: string;
} 