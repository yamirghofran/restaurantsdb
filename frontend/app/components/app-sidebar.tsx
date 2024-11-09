import * as React from "react"
import { useNavigate, useSearchParams } from "@remix-run/react"
import { SearchForm } from "~/components/search-form"
import { VersionSwitcher } from "~/components/version-switcher"
import type { Restaurant } from "~/types/menu"
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarRail,
} from "~/components/ui/sidebar"

interface AppSidebarProps extends React.ComponentProps<typeof Sidebar> {
  restaurants: Restaurant[];
  currentRestaurantId?: number;
}

export function AppSidebar({ 
  restaurants, 
  currentRestaurantId,
  ...props 
}: AppSidebarProps) {
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();
  
  const currentRestaurant = React.useMemo(
    () => restaurants.find(r => r.id === currentRestaurantId),
    [restaurants, currentRestaurantId]
  );

  // Get all menu versions for the current restaurant
  const menuVersions = React.useMemo(() => {
    if (!currentRestaurant?.current_menu) return [];
    
    return [{
      id: currentRestaurant.current_menu.id,
      version: currentRestaurant.current_menu.version_number.toString(),
      date: new Date(currentRestaurant.current_menu.effective_date).toLocaleDateString(),
      is_current: currentRestaurant.current_menu.is_current
    }];
  }, [currentRestaurant]);

  const handleRestaurantClick = (restaurantId: number) => {
    // Update the URL with the selected restaurant
    setSearchParams({ restaurantId: restaurantId.toString() });
  };

  return (
    <Sidebar {...props}>
      <SidebarHeader>
        {currentRestaurant && menuVersions.length > 0 && (
          <VersionSwitcher
            versions={menuVersions.map(v => v.version)}
            defaultVersion={menuVersions.find(v => v.is_current)?.version || menuVersions[0].version}
            restaurantName={currentRestaurant.name}
            onVersionChange={(version) => {
              const versionData = menuVersions.find(v => v.version === version);
              if (versionData) {
                setSearchParams(prev => {
                  prev.set('versionId', versionData.id.toString());
                  return prev;
                });
              }
            }}
          />
        )}
        <SearchForm 
          onSearch={(query) => {
            setSearchParams(prev => {
              if (query) {
                prev.set('q', query);
              } else {
                prev.delete('q');
              }
              return prev;
            });
          }}
        />
      </SidebarHeader>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Restaurants</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {restaurants.map((restaurant) => (
                <SidebarMenuItem key={restaurant.id}>
                  <SidebarMenuButton 
                    isActive={restaurant.id === currentRestaurantId}
                    onClick={() => handleRestaurantClick(restaurant.id)}
                  >
                    <div className="flex flex-col gap-0.5">
                      <span>{restaurant.name}</span>
                      {restaurant.cuisine_type && (
                        <span className="text-xs text-muted-foreground">
                          {restaurant.cuisine_type}
                        </span>
                      )}
                    </div>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
      <SidebarRail />
    </Sidebar>
  )
}
