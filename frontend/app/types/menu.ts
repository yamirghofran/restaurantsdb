export interface MenuItem {
  id: number;
  name: string;
  description: string;
  price: string;
  is_available: boolean;
  spice_level: number;
  display_order: number;
  dietary_restrictions: number[];
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