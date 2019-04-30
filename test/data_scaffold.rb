module DataScaffold
  def self.data_sample
    {
      "name" => "cloudnasium"
    }
  end

  def self.schema_sample
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
              "patternProperties" => {
                "^\\w+$" => {
                  "type" => ["null", "string"]
                }
              }
            },
            "contrived" => {
              "allOf" => [
                { "maxLength" => 30 },
                { "minLength" => 3 }
              ],
              "anyOf" => [
                { "minLength" => 3 },
                { "minLength" => 5 }
              ],
              "oneOf" => [
                { "pattern" => "^(foo|aaa)$" },
                { "pattern" => "^(foo|zzz)$" }
              ],
              "not" => { "pattern" => "^$" }
            },
            "contrived_plus" => {
              "allOf" => [
                { "$ref" => "/schemata/app#/definitions/contrived/allOf/0" },
                { "$ref" => "/schemata/app#/definitions/contrived/allOf/1" }
              ],
              "anyOf" => [
                { "$ref" => "/schemata/app#/definitions/contrived/anyOf/0" },
                { "$ref" => "/schemata/app#/definitions/contrived/anyOf/1" }
              ],
              "oneOf" => [
                { "$ref" => "/schemata/app#/definitions/contrived/oneOf/0" },
                { "$ref" => "/schemata/app#/definitions/contrived/oneOf/1" }
              ],
              "not" => {
                "$ref" => "/schemata/app#/definitions/contrived/not"
              }
            },
            "cost" => {
              "description" => "running price of an app",
              "example" => 35.01,
              "maximum" => 1000.00,
              "exclusiveMaximum" => true,
              "minimum" => 0.0,
              "exclusiveMinimum" => false,
              "multipleOf" => 0.01,
              "readOnly" => false,
              "type" => ["number"],
            },
            "flags" => {
              "description" => "flags for an app",
              "example" => ["websockets"],
              "items" => {
                "pattern" => "^[a-z][a-z\\-]*[a-z]$"
              },
              "maxItems" => 10,
              "minItems" => 1,
              "readOnly" => false,
              "type" => ["array"],
              "uniqueItems" => true
            },
            "id" => {
              "description" => "integer identifier of an app",
              "example" => 1,
              "maximum" => 10000,
              "exclusiveMaximum" => false,
              "minimum" => 0,
              "exclusiveMinimum" => true,
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
              "default" => "hello-world",
              "description" => "unique name of app",
              "example" => "name",
              "maxLength" => 30,
              "minLength" => 3,
              "pattern" => "^[a-z][a-z0-9-]{3,30}$",
              "readOnly" => false,
              "type" => ["string"]
            },
            "owner" => {
              "description" => "owner of the app",
              "format" => "email",
              "example" => "dwarf@example.com",
              "readOnly" => false,
              "type" => ["string"]
            },
            "production" => {
              "description" => "whether this is a production app",
              "example" => false,
              "readOnly" => false,
              "type" => ["boolean"]
            },
            "role" => {
              "description" => "name of a role on an app",
              "example" => "collaborator",
              "readOnly" => true,
              "type" => ["string"],
            },
            "roles" => {
              "additionalProperties" => true,
              "patternProperties" => {
                "^\\w+$" => {
                  "$ref" => "/schemata/app#/definitions/role"
                }
              }
            },
            "ssl" => {
              "description" => "whether this app has SSL termination",
              "example" => false,
              "readOnly" => false,
              "type" => ["boolean"]
            },
            "visibility" => {
              "description" => "the visibility of hte app",
              "enum" => ["private", "public"],
              "example" => false,
              "readOnly" => false,
              "type" => ["string"]
            },
          },
          "properties" => {
            "config_vars" => {
              "$ref" => "/schemata/app#/definitions/config_vars"
            },
            "contrived" => {
              "$ref" => "/schemata/app#/definitions/contrived"
            },
            "cost" => {
              "$ref" => "/schemata/app#/definitions/cost"
            },
            "flags" => {
              "$ref" => "/schemata/app#/definitions/flags"
            },
            "id" => {
              "$ref" => "/schemata/app#/definitions/id"
            },
            "name" => {
              "$ref" => "/schemata/app#/definitions/name"
            },
            "owner" => {
              "$ref" => "/schemata/app#/definitions/owner"
            },
            "production" => {
              "$ref" => "/schemata/app#/definitions/production"
            },
            "ssl" => {
              "$ref" => "/schemata/app#/definitions/ssl"
            },
            "visibility" => {
              "$ref" => "/schemata/app#/definitions/visibility"
            }
          },
          "additionalProperties" => false,
          "dependencies" => {
            "production" => "ssl",
            "ssl" => {
              "properties" => {
                "cost" => {
                  "minimum" => 20.0,
                },
                "name" => {
                  "$ref" => "/schemata/app#/definitions/name"
                },
              }
            }
          },
          "maxProperties" => 10,
          "minProperties" => 1,
          "required" => ["name"],
          "links" => [
            "description" => "Create a new app.",
            "href" => "/apps",
            "method" => "POST",
            "rel" => "create",
            "schema" => {
              "properties" => {
                "name" => {
                  "$ref" => "#/definitions/app/definitions/name"
                },
              }
            },
            "targetSchema" => {
              "$ref" => "#/definitions/app"
            }
          ],
          "media" => {
            "type" => "application/json"
          },
          "pathStart" => "/",
          "readOnly" => false
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

  def self.schema_1
    {
      "id" => "http://json-schema.org/draft-04/schema#",
      "$schema" => "http://json-schema.org/draft-04/schema#",
      "description" => "Core schema meta-schema",
      "definitions" => {
        "schemaArray" => {
          "type" => "array",
          "minItems" => 1,
          "items" => { "$ref" => "#" }
        },
        "positiveInteger" => {
          "type" => "integer",
          "minimum" => 0
        },
        "positiveIntegerDefault0" => {
          "allOf" => [ { "$ref" => "#/definitions/positiveInteger" }, { "default" => 0 } ]
        },
        "simpleTypes" => {
          "enum" => [ "array", "boolean", "integer", "null", "number", "object", "string" ]
        },
        "stringArray" => {
          "type" => "array",
          "items" => { "type" => "string" },
          "minItems" => 1,
          "uniqueItems" => true
        }
      },
      "type" => "object",
      "properties" => {
        "id" => {
          "type" => "string",
          "format" => "uri"
        },
        "$schema" => {
          "type" => "string",
          "format" => "uri"
        },
        "title" => {
          "type" => "string"
        },
        "description" => {
          "type" => "string"
        },
        "default" => {},
        "multipleOf" => {
          "type" => "number",
          "minimum" => 0,
          "exclusiveMinimum" => true
        },
        "maximum" => {
          "type" => "number"
        },
        "exclusiveMaximum" => {
          "type" => "boolean",
          "default" => false
        },
        "minimum" => {
          "type" => "number"
        },
        "exclusiveMinimum" => {
          "type" => "boolean",
          "default" => false
        },
        "maxLength" => { "$ref" => "#/definitions/positiveInteger" },
        "minLength" => { "$ref" => "#/definitions/positiveIntegerDefault0" },
        "pattern" => {
          "type" => "string",
          "format" => "regex"
        },
        "additionalItems" => {
          "anyOf" => [
            { "type" => "boolean" },
            { "$ref" => "#" }
          ],
          "default" => {}
        },
        "items" => {
          "anyOf" => [
            { "$ref" => "#" },
            { "$ref" => "#/definitions/schemaArray" }
          ],
          "default" => {}
        },
        "maxItems" => { "$ref" => "#/definitions/positiveInteger" },
        "minItems" => { "$ref" => "#/definitions/positiveIntegerDefault0" },
        "uniqueItems" => {
          "type" => "boolean",
          "default" => false
        },
        "maxProperties" => { "$ref" => "#/definitions/positiveInteger" },
        "minProperties" => { "$ref" => "#/definitions/positiveIntegerDefault0" },
        "required" => { "$ref" => "#/definitions/stringArray" },
        "additionalProperties" => {
          "anyOf" => [
            { "type" => "boolean" },
            { "$ref" => "#" }
          ],
          "default" => {}
        },
        "definitions" => {
          "type" => "object",
          "additionalProperties" => { "$ref" => "#" },
          "default" => {}
        },
        "properties" => {
          "type" => "object",
          "additionalProperties" => { "$ref" => "#" },
          "default" => {}
        },
        "patternProperties" => {
          "type" => "object",
          "additionalProperties" => { "$ref" => "#" },
          "default" => {}
        },
        "dependencies" => {
          "type" => "object",
          "additionalProperties" => {
            "anyOf" => [
              { "$ref" => "#" },
              { "$ref" => "#/definitions/stringArray" }
            ]
          }
        },
        "enum" => {
          "type" => "array",
          "minItems" => 1,
          "uniqueItems" => true
        },
        "type" => {
          "anyOf" => [
            { "$ref" => "#/definitions/simpleTypes" },
            {
              "type" => "array",
              "items" => { "$ref" => "#/definitions/simpleTypes" },
              "minItems" => 1,
              "uniqueItems" => true
            }
          ]
        },
        "allOf" => { "$ref" => "#/definitions/schemaArray" },
        "anyOf" => { "$ref" => "#/definitions/schemaArray" },
        "oneOf" => { "$ref" => "#/definitions/schemaArray" },
        "not" => { "$ref" => "#" }
      },
      "dependencies" => {
        "exclusiveMaximum" => [ "maximum" ],
        "exclusiveMinimum" => [ "minimum" ]
      },
      "default" => {}
    }
  end

  def self.schema_2
    {
      "$schema" => "http://json-schema.org/draft-04/hyper-schema#",
      "id" => "http://json-schema.org/draft-04/hyper-schema#",
      "title" => "JSON Hyper-Schema",
      "allOf" => [
        {
          "$ref" => "http://json-schema.org/draft-04/schema#"
        }
      ],
      "properties" => {
        "additionalItems" => {
          "anyOf" => [
            {
              "type" => "boolean"
            },
            {
              "$ref" => "#"
            }
          ]
        },
        "additionalProperties" => {
          "anyOf" => [
            {
              "type" => "boolean"
            },
            {
              "$ref" => "#"
            }
          ]
        },
        "dependencies" => {
          "additionalProperties" => {
            "anyOf" => [
              {
                "$ref" => "#"
              },
              {
                "type" => "array"
              }
            ]
          }
        },
        "items" => {
          "anyOf" => [
            {
              "$ref" => "#"
            },
            {
              "$ref" => "#/definitions/schemaArray"
            }
          ]
        },
        "definitions" => {
          "additionalProperties" => {
            "$ref" => "#"
          }
        },
        "patternProperties" => {
          "additionalProperties" => {
            "$ref" => "#"
          }
        },
        "properties" => {
          "additionalProperties" => {
            "$ref" => "#"
          }
        },
        "allOf" => {
          "$ref" => "#/definitions/schemaArray"
        },
        "anyOf" => {
          "$ref" => "#/definitions/schemaArray"
        },
        "oneOf" => {
          "$ref" => "#/definitions/schemaArray"
        },
        "not" => {
          "$ref" => "#"
        },

        "links" => {
          "type" => "array",
          "items" => {
            "$ref" => "#/definitions/linkDescription"
          }
        },
        "fragmentResolution" => {
          "type" => "string"
        },
        "media" => {
          "type" => "object",
          "properties" => {
            "type" => {
              "description" => "A media type, as described in RFC 2046",
              "type" => "string"
            },
            "binaryEncoding" => {
              "description" => "A content encoding scheme, as described in RFC 2045",
              "type" => "string"
            }
          }
        },
        "pathStart" => {
          "description" => "Instances' URIs must start with this value for this schema to apply to them",
          "type" => "string",
          "format" => "uri"
        }
      },
      "definitions" => {
        "schemaArray" => {
          "type" => "array",
          "items" => {
            "$ref" => "#"
          }
        },
        "linkDescription" => {
          "title" => "Link Description Object",
          "type" => "object",
          "required" => [ "href", "rel" ],
          "properties" => {
            "href" => {
              "description" => "a URI template, as defined by RFC 6570, with the addition of the $, ( and ) characters for pre-processing",
              "type" => "string"
            },
            "rel" => {
              "description" => "relation to the target resource of the link",
              "type" => "string"
            },
            "title" => {
              "description" => "a title for the link",
              "type" => "string"
            },
            "targetSchema" => {
              "description" => "JSON Schema describing the link target",
              "$ref" => "#"
            },
            "mediaType" => {
              "description" => "media type (as defined by RFC 2046) describing the link target",
              "type" => "string"
            },
            "method" => {
              "description" => "method for requesting the target of the link (e.g. for HTTP this might be \"GET\" or \"DELETE\")",
              "type" => "string"
            },
            "encType" => {
              "description" => "The media type in which to submit data along with the request",
              "type" => "string",
              "default" => "application/json"
            },
            "schema" => {
              "description" => "Schema describing the data to submit along with the request",
              "$ref" => "#"
            }
          }
        }
      },
      "links" => [
        {
          "rel" => "self",
          "href" => "{+id}"
        },
        {
          "rel" => "full",
          "href" => "{+($ref)}"
        }
      ]
    }
  end
end
