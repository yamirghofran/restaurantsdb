import type { Restaurant } from "~/types/menu";
import { Card, CardHeader, CardTitle } from "~/components/ui/card";
import { VersionSwitcher } from "~/components/version-switcher";

interface RestaurantMenuCardProps {
  restaurant: Restaurant;
}

const CURRENCY_SYMBOL_MAP: Record<string, string> = {
  '€': 'EUR',
  '$': 'USD',
  '£': 'GBP',
  '¥': 'JPY',
};

export default function RestaurantMenuCard({ restaurant }: RestaurantMenuCardProps) {
  const currentMenu = restaurant.current_menu;

  if (!currentMenu) {
    return (
      <div className="p-4">
        <p>No menu available for this restaurant.</p>
      </div>
    );
  }

  return (
    <div className="p-4 space-y-6">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold">{restaurant.name}</h2>
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
      {currentMenu.sections.map((section) => (
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


