export interface MenuItem {
  id: number;
  name: string;
  description: string;
  price: string;
  currency: string;
  calories: number;
  spice_level: number;
  is_available: boolean;
  display_order: number;
  dietary_restrictions: DietaryRestriction[];
  created_at: string;
  restaurant_id: number;
  restaurant_name: string;
}

export interface MenuSection {
  id: number;
  name: string;
  description: string;
  display_order: number;
  items: MenuItem[];
}

export interface MenuVersion {
  id: number;
  name: string;
  is_current: boolean;
  source_type: string;
  sections: MenuSection[];
}

export interface Restaurant {
  id: number;
  name: string;
  address: string;
  cuisine_type: string;
  is_active: boolean;
  current_menu: MenuVersion;
  all_versions: MenuVersion[];
} 