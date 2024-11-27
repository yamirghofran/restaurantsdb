from openai import OpenAI
client = OpenAI()

response = client.chat.completions.create(
  model="gpt-4o-mini",
  messages=[
    {
      "role": "system",
      "content": [
        {
          "type": "text",
          "text": "Return information from a restaurant menu in the specified son schema."
        }
      ]
    }
  ],
  response_format={
    "type": "json_schema",
    "json_schema": {
      "name": "menu_response",
      "strict": True,
      "schema": {
        "type": "object",
        "properties": {
          "restaurant": {
            "type": "object",
            "properties": {
              "name": {
                "type": "string"
              },
              "address": {
                "type": "string"
              },
              "phone": {
                "type": "string"
              },
              "website": {
                "type": "string"
              },
              "cuisine_type": {
                "type": "string"
              }
            },
            "required": [
              "name",
              "address",
              "phone",
              "website",
              "cuisine_type"
            ],
            "additionalProperties": False
          },
          "menu_version": {
            "type": "object",
            "properties": {
              "version_number": {
                "type": "integer"
              },
              "effective_date": {
                "type": "string"
              },
              "source_type": {
                "type": "string",
                "enum": [
                  "upload",
                  "scrape",
                  "manual"
                ]
              },
              "source_url": {
                "type": "string"
              }
            },
            "required": [
              "version_number",
              "effective_date",
              "source_type",
              "source_url"
            ],
            "additionalProperties": False
          },
          "sections": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "name": {
                  "type": "string"
                },
                "description": {
                  "type": "string"
                },
                "display_order": {
                  "type": "integer"
                },
                "menu_items": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "name": {
                        "type": "string"
                      },
                      "description": {
                        "type": "string"
                      },
                      "price": {
                        "type": "number"
                      },
                      "currency": {
                        "type": "string"
                      },
                      "calories": {
                        "type": "integer"
                      },
                      "spice_level": {
                        "type": "integer"
                      },
                      "is_available": {
                        "type": "boolean"
                      },
                      "display_order": {
                        "type": "integer"
                      },
                      "dietary_restrictions": {
                        "type": "array",
                        "items": {
                          "type": "string"
                        }
                      }
                    },
                    "required": [
                      "name",
                      "description",
                      "price",
                      "currency",
                      "calories",
                      "spice_level",
                      "is_available",
                      "display_order",
                      "dietary_restrictions"
                    ],
                    "additionalProperties": False
                  }
                }
              },
              "required": [
                "name",
                "description",
                "display_order",
                "menu_items"
              ],
              "additionalProperties": False
            }
          }
        },
        "required": [
          "restaurant",
          "menu_version",
          "sections"
        ],
        "additionalProperties": False
      }
    }
  },
  temperature=0.85,
  max_tokens=200000,
  top_p=1,
  frequency_penalty=0,
  presence_penalty=0
)

print(response)