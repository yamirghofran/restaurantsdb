export interface MenuItem {
  id: number;
  name: string;
  description?: string;
  price: number;
  currency: string;
  is_available: boolean;
  dietary_restrictions: {
    id: number;
    name: string;
    description?: string;
  }[];
}

export interface MenuSection {
  id: number;
  name: string;
  description?: string;
  menu_items: MenuItem[];
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
  address?: string;
  phone?: string;
  website?: string;
  cuisine_type?: string;
  current_menu?: MenuVersion;
  all_versions?: MenuVersion[];
} 