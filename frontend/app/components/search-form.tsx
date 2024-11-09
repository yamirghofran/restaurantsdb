import { Search } from "lucide-react"
import * as React from "react"

import { Label } from "~/components/ui/label"
import {
  SidebarGroup,
  SidebarGroupContent,
  SidebarInput,
} from "~/components/ui/sidebar"

interface SearchFormProps extends Omit<React.ComponentProps<"form">, "onSubmit"> {
  onSearch?: (query: string) => void;
}

export function SearchForm({ onSearch, ...props }: SearchFormProps) {
  const [query, setQuery] = React.useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSearch?.(query);
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
