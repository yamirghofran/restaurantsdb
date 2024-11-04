import React, { useState } from 'react'
import { Card, CardContent, CardFooter, CardHeader, CardTitle, CardDescription } from "~/components/ui/card"
import { Button } from "~/components/ui/button"
import { Badge } from "~/components/ui/badge"
import { Separator } from "~/components/ui/separator"
import { ChevronLeft, ChevronRight } from "lucide-react"

const restaurants = [
    {
      id: 1,
      name: "Gourmet Bistro",
      description: "Fine dining with a modern twist",
      menuVersions: ["Summer 2023", "Fall 2023", "Winter 2024"],
      menu: {
        "Appetizers": [
          { name: "Truffle Fries", price: 12, dietary: ["Vegetarian"] },
          { name: "Caprese Salad", price: 14, dietary: ["Vegetarian", "Gluten-Free"] },
          { name: "Escargot", price: 16, dietary: [] },
          { name: "Lobster Bisque", price: 15, dietary: ["Gluten-Free"] },
        ],
        "Main Courses": [
          { name: "Filet Mignon", price: 38, dietary: ["Gluten-Free"] },
          { name: "Vegan Risotto", price: 24, dietary: ["Vegan", "Gluten-Free"] },
          { name: "Grilled Sea Bass", price: 32, dietary: ["Gluten-Free"] },
          { name: "Truffle Pasta", price: 28, dietary: ["Vegetarian"] },
        ],
        "Desserts": [
          { name: "Chocolate Lava Cake", price: 10, dietary: ["Vegetarian"] },
          { name: "Fruit Sorbet", price: 8, dietary: ["Vegan", "Gluten-Free"] },
          { name: "Crème Brûlée", price: 9, dietary: ["Vegetarian", "Gluten-Free"] },
          { name: "Cheese Plate", price: 14, dietary: ["Vegetarian"] },
        ]
      }
    },
    {
      id: 2,
      name: "Seaside Shack",
      description: "Casual seafood dining by the beach",
      menuVersions: ["Spring 2023", "Summer 2023"],
      menu: {
        "Starters": [
          { name: "Clam Chowder", price: 8, dietary: [] },
          { name: "Calamari", price: 12, dietary: [] },
          { name: "Shrimp Cocktail", price: 14, dietary: ["Gluten-Free"] },
        ],
        "Mains": [
          { name: "Fish and Chips", price: 18, dietary: [] },
          { name: "Grilled Salmon", price: 22, dietary: ["Gluten-Free"] },
          { name: "Lobster Roll", price: 24, dietary: [] },
        ],
        "Sides": [
          { name: "Coleslaw", price: 4, dietary: ["Vegetarian"] },
          { name: "Sweet Potato Fries", price: 6, dietary: ["Vegan"] },
          { name: "Corn on the Cob", price: 5, dietary: ["Vegetarian", "Gluten-Free"] },
        ]
      }
    }
  ]

function RestaurantMenuCard() {
    const [selectedRestaurant, setSelectedRestaurant] = useState(restaurants[0])
    const [selectedVersion, setSelectedVersion] = useState(selectedRestaurant.menuVersions[0])
    const [currentPage, setCurrentPage] = useState(1)
    const itemsPerPage = 10
  
    const allMenuItems = Object.entries(selectedRestaurant.menu).flatMap(([section, items]) => 
      items.map(item => ({ ...item, section }))
    )
  
    const totalPages = Math.ceil(allMenuItems.length / itemsPerPage)
    const paginatedItems = allMenuItems.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage)
  
  return (
    <div className="p-6">
<Card className="mb-6">
  <CardHeader>
    <CardTitle>{selectedRestaurant.name}</CardTitle>
    <CardDescription>{selectedRestaurant.description}</CardDescription>
  </CardHeader>
  <CardContent>
    <p className="text-sm text-muted-foreground mb-4">
      Current Menu Version: {selectedVersion}
    </p>
    <div className="space-y-6">
      {paginatedItems.map((item, index) => (
        <div key={index}>
          {(index === 0 || item.section !== paginatedItems[index - 1].section) && (
            <h3 className="text-lg font-semibold mt-4 mb-2">{item.section}</h3>
          )}
          <div className="flex justify-between items-center">
            <div>
              <p className="font-medium">{item.name}</p>
              <div className="flex space-x-2 mt-1">
                {item.dietary.map((diet) => (
                  <Badge key={diet} variant="secondary">{diet}</Badge>
                ))}
              </div>
            </div>
            <p className="font-semibold">${item.price.toFixed(2)}</p>
          </div>
          {index < paginatedItems.length - 1 && <Separator className="my-4" />}
        </div>
      ))}
    </div>
  </CardContent>
  <CardFooter className="flex justify-between">
    <Button
      variant="outline"
      onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
      disabled={currentPage === 1}
    >
      <ChevronLeft className="h-4 w-4 mr-2" />
      Previous
    </Button>
    <div className="text-sm text-muted-foreground">
      Page {currentPage} of {totalPages}
    </div>
    <Button
      variant="outline"
      onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
      disabled={currentPage === totalPages}
    >
      Next
      <ChevronRight className="h-4 w-4 ml-2" />
    </Button>
  </CardFooter>
      </Card>
    </div>
  )
}

export default RestaurantMenuCard


