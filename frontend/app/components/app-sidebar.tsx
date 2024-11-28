import * as React from "react"
import { useNavigate, useSearchParams, useFetcher, useRevalidator } from "@remix-run/react"
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
import { Button } from "~/components/ui/button"
import { Input } from "./ui/input"
import { uploadMenuFile } from "~/utils/api"
import { Loader2 } from "lucide-react"
import { Slider } from "./ui/slider"

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
  const [isUploading, setIsUploading] = React.useState(false);
  const [selectedFile, setSelectedFile] = React.useState<File | null>(null);
  const fetcher = useFetcher();
  const [uploadStatus, setUploadStatus] = React.useState<'idle' | 'uploading' | 'success' | 'error'>('idle');
  const revalidator = useRevalidator();
  
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

  const handleFileUpload = async () => {
    if (!selectedFile) return;

    setUploadStatus('uploading');

    try {
      await uploadMenuFile(selectedFile);
      setUploadStatus('success');
      
      // Revalidate the route data
      revalidator.revalidate();
    } catch (error) {
      console.error('Menu upload failed:', error);
      setUploadStatus('error');
    }

    setIsUploading(false);
    setSelectedFile(null);
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
        {!isUploading && (
          <Button 
            size="sm" 
            onClick={() => {
              setIsUploading(true);
              setUploadStatus('idle');
            }}
          >
            Upload Menu
          </Button>
        )}
      
        {isUploading && (
          <Input 
            type="file" 
            onChange={(e) => {
              const file = e.target.files?.[0];
              if (file) setSelectedFile(file);
            }} 
          />
        )}
        {isUploading && (
          <div className="flex gap-2">
            <Button 
              size="sm" 
              disabled={!selectedFile || uploadStatus === 'uploading'}
              onClick={handleFileUpload}
              className={uploadStatus === 'uploading' ? 'animate-spin' : ''}
            >
              {uploadStatus === 'uploading' ? 'Uploading...' : selectedFile ? 'Upload' : 'Select File'}
            </Button>
            <Button 
              size="sm" 
              variant="outline" 
              onClick={() => {
                setIsUploading(false);
                setSelectedFile(null);
                setUploadStatus('idle');
              }}
            >
              Cancel
            </Button>
          </div>
        )}
        {uploadStatus === 'success' && <div className="text-green-500">Upload successful!</div>}
        {uploadStatus === 'error' && <div className="text-red-500">Upload failed. Please try again.</div>}
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
