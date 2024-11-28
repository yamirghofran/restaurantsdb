import { Search } from "lucide-react"
import * as React from "react"

import { Label } from "~/components/ui/label"
import {
  SidebarGroup,
  SidebarGroupContent,
  SidebarInput,
} from "~/components/ui/sidebar"
import { fetchFromApi } from "~/utils/api";
import type { Restaurant, MenuItem } from "~/types/menu";

interface SearchFormProps extends Omit<React.ComponentProps<"form">, "onSubmit"> {
  onSearch?: (results: { restaurants: Restaurant[], menu_items: MenuItem[] }) => void;
}

export function SearchForm({ onSearch, ...props }: SearchFormProps) {
  const [query, setQuery] = React.useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (query.trim() !== "") {
      try {
        const response = await fetchFromApi<{ restaurants: Restaurant[], menu_items: MenuItem[] }>(`/restaurants/unified_search/?q=${encodeURIComponent(query)}`);
        onSearch?.(response);
      } catch (error) {
        console.error('Search failed:', error);
      }
    } else {
      onSearch?.({ restaurants: [], menu_items: [] });
    }
  };

  return (
    <form onSubmit={handleSubmit} {...props}>
      <SidebarGroup className="py-0">
        <SidebarGroupContent className="relative">
          <Label htmlFor="search" className="sr-only">
            Search
          </Label>
          <SidebarInput
            id="search"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search restaurants..."
            className="pl-8"
          />
          <Search className="pointer-events-none absolute left-2 top-1/2 size-4 -translate-y-1/2 select-none opacity-50" />
        </SidebarGroupContent>
      </SidebarGroup>
    </form>
  )
}
