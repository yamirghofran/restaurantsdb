import * as React from "react"

import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "~/components/ui/select"

interface VersionSwitcherProps {
  versions: Array<{id: number, created_at: string}>;
  selectedVersion?: number;
  onVersionChange: (versionId: number) => void;
}

export function VersionSwitcher({ versions, selectedVersion, onVersionChange }: VersionSwitcherProps) {
  return (
    <Select 
      defaultValue={selectedVersion?.toString()}
      value={selectedVersion?.toString()} 
      onValueChange={(value) => onVersionChange(parseInt(value))}
    >
      <SelectTrigger className="w-[180px]">
        <SelectValue placeholder="Select version" />
      </SelectTrigger>
      <SelectContent>
        <SelectGroup>
          <SelectLabel>Menu Versions</SelectLabel>
          {versions.map((version) => (
            <SelectItem key={version.id} value={version.id.toString()}>
              Version {version.version_number}
            </SelectItem>
          ))}
        </SelectGroup>
      </SelectContent>
    </Select>
  )
}
