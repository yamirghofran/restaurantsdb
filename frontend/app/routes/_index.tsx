import type { LoaderFunction } from "@remix-run/node";
import { useLoaderData, useParams } from "@remix-run/react";
import { AppSidebar } from "~/components/app-sidebar";
import type { Restaurant } from "~/types/menu";
import { fetchFromApi } from "~/utils/api";
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
}

export const loader: LoaderFunction = async ({ request }) => {
  try {
    // Get restaurants
    const restaurantsResponse = await fetchFromApi<{ results: Restaurant[] }>('/restaurants/');
    const restaurants = restaurantsResponse.results;
    
    // Get current restaurant from URL or default to first one
    const url = new URL(request.url);
    const restaurantId = url.searchParams.get('restaurantId');
    
    let currentRestaurant = null;
    if (restaurantId) {
      // Get full details for selected restaurant
      currentRestaurant = await fetchFromApi<Restaurant>(`/restaurants/${restaurantId}/full_details/`);
    } else if (restaurants.length > 0) {
      // Get full details for first restaurant
      currentRestaurant = await fetchFromApi<Restaurant>(`/restaurants/${restaurants[0].id}/full_details/`);
    }
    
    return { 
      restaurants,
      currentRestaurant
    };
  } catch (error) {
    console.error('Failed to load restaurants:', error);
    throw new Response("Failed to load restaurants", { status: 500 });
  }
};

export default function Index() {
  const { restaurants, currentRestaurant } = useLoaderData<LoaderData>();

  console.log(Array.isArray(restaurants), restaurants);

  return (
    <SidebarProvider>
      <AppSidebar 
        restaurants={restaurants} 
        currentRestaurantId={currentRestaurant?.id}
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
