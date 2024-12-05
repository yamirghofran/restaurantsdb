import { useState } from "react";
import type { MenuItem, Restaurant } from "~/types/menu";
import { Card, CardHeader, CardTitle } from "~/components/ui/card";
import { VersionSwitcher } from "~/components/version-switcher";

interface RestaurantMenuCardProps {
  restaurant: Restaurant;
}

interface DietaryFilter {
  id: string;
  label: string;
  exclude: boolean;
}

const DIETARY_FILTERS: DietaryFilter[] = [
  { id: 'vegetarian', label: 'Vegetarian/Vegan', exclude: false },
  { id: 'seafood', label: 'Seafood', exclude: false },
  { id: 'gluten', label: 'Gluten-Free', exclude: true },
  { id: 'dairy', label: 'Dairy-Free', exclude: true },
  { id: 'alcohol', label: 'Alcohol', exclude: false }
];

const CURRENCY_SYMBOL_MAP: Record<string, string> = {
  '€': 'EUR',
  '$': 'USD',
  '£': 'GBP',
  '¥': 'JPY',
};

export default function RestaurantMenuCard({ restaurant }: RestaurantMenuCardProps) {
  const [activeFilters, setActiveFilters] = useState<Set<string>>(new Set());
  const currentMenu = restaurant.current_menu;

  const toggleFilter = (filterId: string) => {
    setActiveFilters(prev => {
      const newFilters = new Set(prev);
      if (newFilters.has(filterId)) {
        newFilters.delete(filterId);
      } else {
        newFilters.add(filterId);
      }
      return newFilters;
    });
  };

  const filterItems = (items: MenuItem[]) => {
    if (activeFilters.size === 0) return items;
    
    return items.filter(item => {
      const restrictions = new Set(
        item.dietary_restrictions.map(r => r.name.toLowerCase())
      );

      return Array.from(activeFilters).every(filter => {
        const dietaryFilter = DIETARY_FILTERS.find(df => df.id === filter);
        if (!dietaryFilter) return true;

        if (dietaryFilter.exclude) {
          // For gluten-free and dairy-free, we want items that DON'T have these tags
          return !restrictions.has(filter);
        } else {
          // For other filters, we want items that DO have these tags
          return restrictions.has(filter);
        }
      });
    });
  };

  if (!currentMenu) {
    return (
      <div className="p-4">
        <p>No menu available for this restaurant.</p>
      </div>
    );
  }
  
  return (
    <div className="p-4 space-y-6">
      <div className="space-y-2">
        <h2 className="text-2xl font-bold">{restaurant.name}</h2>
        
        <div className="text-sm text-gray-600 space-y-1">
          {restaurant.address && (
            <p>📍 {restaurant.address}</p>
          )}
          {restaurant.phone && (
            <p>📞 {restaurant.phone}</p>
          )}
          {restaurant.website && (
            <p>
              🌐 <a 
                href={restaurant.website} 
                target="_blank" 
                rel="noopener noreferrer"
                className="text-blue-600 hover:underline"
              >
                {restaurant.website}
              </a>
            </p>
          )}
          {restaurant.cuisine_type && (
            <p>🍽️ {restaurant.cuisine_type}</p>
          )}
        </div>

        {restaurant.all_versions && restaurant.all_versions.length > 1 && (
          <VersionSwitcher
            versions={restaurant.all_versions}
            selectedVersion={currentMenu.id}
            onVersionChange={(versionId) => {
              const params = new URLSearchParams(window.location.search);
              params.set('versionId', versionId.toString());
              window.location.search = params.toString();
            }}
          />
        )}
      </div>

      <div className="flex flex-wrap gap-2 mb-4">
        {DIETARY_FILTERS.map(filter => (
          <div
            key={filter.id}
            onClick={() => toggleFilter(filter.id)}
            className={`
              px-3 py-1.5 rounded-full text-sm cursor-pointer transition-colors
              ${activeFilters.has(filter.id)
                ? 'bg-blue-500 text-white'
                : 'bg-gray-100 hover:bg-gray-200'
              }
            `}
          >
            {filter.label}
          </div>
        ))}
      </div>

      {currentMenu.sections
        .map(section => ({
          ...section,
          menu_items: filterItems(section.menu_items)
        }))
        .filter(section => section.menu_items.length > 0)
        .map((section) => (
          <Card key={section.id}>
            <CardHeader>
              <CardTitle>{section.name}</CardTitle>
              {section.description && (
                <p className="text-sm text-gray-600">{section.description}</p>
              )}
            </CardHeader>
            <div className="mx-4 border-t border-1 mb-6 border-black"></div>
            <div className="p-6 pt-0 space-y-4">
              {section.menu_items.map((item) => (
                <div 
                  key={item.id} 
                  className={`flex justify-between gap-4 ${!item.is_available ? 'opacity-50' : ''}`}
                >
                  <div>
                    <div className="flex items-center gap-2">
                      <h3 className="font-medium">{item.name}</h3>
                      {!item.is_available && (
                        <span className="text-xs text-red-500">(Unavailable)</span>
                      )}
                    </div>
                    {item.description && (
                      <p className="text-sm text-gray-600">{item.description}</p>
                    )}
                    <div className="flex gap-2 mt-1">
                      {item.dietary_restrictions.map((restriction) => (
                        <span 
                          key={restriction.id}
                          className="text-xs bg-gray-100 px-2 py-0.5 rounded"
                          title={restriction.description || restriction.name}
                        >
                          {restriction.name}
                        </span>
                      ))}
                    </div>
                  </div>
                  <div className="font-medium">
                    {(() => {
                      try {
                        const currencyCode = CURRENCY_SYMBOL_MAP[item.currency] || item.currency || 'EUR';
                        return new Intl.NumberFormat('en-US', {
                          style: 'currency',
                          currency: currencyCode,
                        }).format(item.price);
                      } catch (e) {
                        return new Intl.NumberFormat('en-US', {
                          style: 'currency',
                          currency: 'EUR',
                        }).format(item.price);
                      }
                    })()}
                  </div>
                </div>
              ))}
            </div>
          </Card>
        ))}
    </div>
  );
}


