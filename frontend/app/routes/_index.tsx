import React from "react";
import type { LoaderFunction } from "@remix-run/node";
import { useLoaderData, useParams, useNavigate } from "@remix-run/react";
import { AppSidebar } from "~/components/app-sidebar";
import type { Restaurant } from "~/types/menu";
import { fetchFromApi, debounce } from "~/utils/api";
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from "~/components/ui/breadcrumb";
import { Separator } from "~/components/ui/separator";
import {
  SidebarInset,
  SidebarProvider,
  SidebarTrigger,
} from "~/components/ui/sidebar";
import RestaurantMenuCard from "~/components/restaurant-menu-card";

interface LoaderData {
  restaurants: Restaurant[];
  currentRestaurant: Restaurant | null;
  statistics: Array<{ restaurant_id: number; total_items: number; avg_price: string; }>;
  filters: { minPrice: string; maxPrice: string; minItems: string; maxItems: string; };
}

export const loader: LoaderFunction = async ({ request }) => {
  try {
    const url = new URL(request.url);
    const minPrice = url.searchParams.get('minPrice') ?? '0';
    const maxPrice = url.searchParams.get('maxPrice') ?? '5000';
    const minItems = url.searchParams.get('minItems') ?? '0';
    const maxItems = url.searchParams.get('maxItems') ?? '100';
    
    // Get statistics first
    const statsResponse = await fetchFromApi<{ results: Array<{ restaurant_id: number; total_items: number; avg_price: string; }> }>(
      `/statistics/?min_price=${minPrice}&max_price=${maxPrice}&min_items=${minItems}&max_items=${maxItems}`
    );
    
    // Get restaurants
    const restaurantsResponse = await fetchFromApi<{ results: Restaurant[] }>('/restaurants/');
    let restaurants = restaurantsResponse.results;
    
    // Filter restaurants based on statistics
    const validRestaurantIds = new Set(statsResponse.results.map(stat => stat.restaurant_id));
    restaurants = restaurants.filter(restaurant => validRestaurantIds.has(restaurant.id));
    
    const restaurantId = url.searchParams.get('restaurantId');
    let currentRestaurant = null;
    if (restaurantId) {
      currentRestaurant = await fetchFromApi<Restaurant>(`/restaurants/${restaurantId}/full_details/`);
    } else if (restaurants.length > 0) {
      currentRestaurant = await fetchFromApi<Restaurant>(`/restaurants/${restaurants[0].id}/full_details/`);
    }
    
    return { restaurants, currentRestaurant, statistics: statsResponse.results, filters: { minPrice, maxPrice, minItems, maxItems } };
  } catch (error) {
    console.error('Failed to load data:', error);
    throw new Response("Failed to load data", { status: 500 });
  }
};

export default function Index() {
  const { restaurants, currentRestaurant, statistics, filters } = useLoaderData<LoaderData>();
  const [priceRange, setPriceRange] = React.useState([
    parseInt(filters.minPrice),
    parseInt(filters.maxPrice)
  ]);
  const [itemCountRange, setItemCountRange] = React.useState([
    parseInt(filters.minItems),
    parseInt(filters.maxItems)
  ]);
  const navigate = useNavigate();

  // Debounce the filter changes
  const debouncedNavigate = React.useCallback(
    debounce((minPrice: number, maxPrice: number, minItems: number, maxItems: number) => {
      const params = new URLSearchParams(window.location.search);
      const restaurantId = params.get('restaurantId');
      
      params.set('minPrice', minPrice.toString());
      params.set('maxPrice', maxPrice.toString());
      params.set('minItems', minItems.toString());
      params.set('maxItems', maxItems.toString());
      
      if (restaurantId) {
        params.set('restaurantId', restaurantId);
      }
      
      navigate(`?${params.toString()}`, { replace: true });
    }, 500),
    [navigate]
  );

  React.useEffect(() => {
    debouncedNavigate(priceRange[0], priceRange[1], itemCountRange[0], itemCountRange[1]);
  }, [priceRange, itemCountRange, debouncedNavigate]);

  console.log(Array.isArray(restaurants), restaurants);

  return (
    <SidebarProvider>
      <AppSidebar 
        restaurants={restaurants} 
        currentRestaurantId={currentRestaurant?.id}
        priceRange={priceRange}
        setPriceRange={setPriceRange}
        itemCountRange={itemCountRange}
        setItemCountRange={setItemCountRange}
      />
      <SidebarInset>
        <header className="flex h-16 shrink-0 items-center gap-2 border-b px-4">
          <SidebarTrigger className="-ml-1" />
          <Separator orientation="vertical" className="mr-2 h-4" />
          <Breadcrumb>
            <BreadcrumbList>
              <BreadcrumbItem className="hidden md:block">
                <BreadcrumbLink href="/">Restaurants</BreadcrumbLink>
              </BreadcrumbItem>
              <BreadcrumbSeparator className="hidden md:block" />
              <BreadcrumbItem>
                <BreadcrumbPage>
                  {currentRestaurant?.name || "Select a Restaurant"}
                </BreadcrumbPage>
              </BreadcrumbItem>
            </BreadcrumbList>
          </Breadcrumb>
        </header>
        {currentRestaurant && (
          <RestaurantMenuCard restaurant={currentRestaurant} />
        )}
      </SidebarInset>
    </SidebarProvider>
  );
}
