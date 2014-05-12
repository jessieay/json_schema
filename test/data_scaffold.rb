module DataScaffold
  def self.sample
    {
      "$schema" => "http://json-schema.org/draft-04/hyper-schema",
      "title" => "Example API",
      "description" => "An example API.",
      "type" => [
        "object"
      ],
      "definitions" => {
        "app" => {
          "$schema" => "http://json-schema.org/draft-04/hyper-schema",
          "title" => "App",
          "description" => "An app.",
          "id" => "schemata/app",
          "type" => [
            "object"
          ],
          "definitions" => {
            "config_vars" => {
              "additionalProperties" => true,
              "patternProperties" => {
                "^\w+$" => {
                  "type" => ["null", "string"]
                }
              }
            },
            "contrived" => {
              "allOf" => [
                { "maxLength" => 30 },
                { "minLength" => 3 }
              ],
              "oneOf" => [
                { "pattern" => "^(|aaa)$" },
                { "pattern" => "^(|zzz)$" }
              ],
              "not" => { "pattern" => "^$" }
            },
            "cost" => {
              "description" => "running price of an app",
              "example" => 35.01,
              "max" => 1000.00,
              "maxExclusive" => true,
              "min" => 0.0,
              "minExclusive" => false,
              "multipleOf" => 0.01,
              "readOnly" => false,
              "type" => ["number"],
            },
            "flags" => {
              "description" => "flags for an app",
              "example" => ["websockets"],
              "maxItems" => 10,
              "minItems" => 0,
              "readOnly" => false,
              "type" => ["array"],
              "uniqueItems" => true
            },
            "id" => {
              "description" => "integer identifier of an app",
              "example" => 1,
              "max" => 10000,
              "maxExclusive" => false,
              "min" => 1,
              "minExclusive" => false,
              "multipleOf" => 1,
              "readOnly" => true,
              "type" => ["integer"],
            },
            "identity" => {
              "anyOf" => [
                { "$ref" => "/schemata/app#/definitions/id" },
                { "$ref" => "/schemata/app#/definitions/name" },
              ]
            },
            "name" => {
              "description" => "unique name of app",
              "example" => "name",
              "maxLength" => 30,
              "minLength" => 3,
              "pattern" => "^[a-z][a-z0-9-]{3,30}$",
              "readOnly" => false,
              "type" => ["string"]
            },
            "production" => {
              "description" => "whether this is a production app",
              "example" => false,
              "readOnly" => false,
              "type" => ["boolean"]
            },
            "ssl" => {
              "description" => "whether this app has SSL termination",
              "example" => false,
              "readOnly" => false,
              "type" => ["boolean"]
            },
          },
          "properties" => {
            "app" => {
              "$ref" => "/schemata/app#/definitions/name"
            },
            "production" => {
              "$ref" => "/schemata/app#/definitions/production"
            },
            "ssl" => {
              "$ref" => "/schemata/app#/definitions/ssl"
            }
          },
          "additionalProperties" => false,
          "dependencies" => {
            "production" => "ssl",
            "ssl" => {
              "properties" => {
                "cost" => {
                  "min" => 20.0,
                }
              }
            }
          },
          "maxProperties" => 10,
          "minProperties" => 1,
          "required" => ["name"]
        }
      },
      "properties" => {
        "app" => {
          "$ref" => "#/definitions/app"
        },
      },
      "links" => [
        {
          "href" => "http://example.com",
          "rel" => "self"
        }
      ]
    }
  end
end