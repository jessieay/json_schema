require "test_helper"

require "json_schema"

describe JsonSchema::Parser do
  before do
    @parser = JsonSchema::Parser.new
  end

  it "parses the basic attributes of a schema" do
    schema = @parser.parse(data)
    assert_nil schema.id
    assert_equal "Example API", schema.title
    assert_equal "An example API.", schema.description
    assert_equal ["object"], schema.type
    assert_equal "/", schema.uri
  end

  it "parses subschemas" do
    schema = @parser.parse(data).definitions_children[0]
    assert_nil schema.reference
    assert_equal "App", schema.title
    assert_equal "An app.", schema.description
    assert_equal "schemata/app", schema.id
    assert_equal ["object"], schema.type
    assert_equal "/schemata/app", schema.uri
    refute_nil schema.parent
  end

  it "parses sub-subschemas" do
    schema = @parser.parse(data).definitions_children[0].definitions_children[0]
    assert_nil schema.reference
    assert_equal "unique name of app", schema.description
    assert_equal ["string"], schema.type
    assert_equal "/schemata/app", schema.uri
    refute_nil schema.parent
  end

  it "parses references" do
    schema = @parser.parse(data).properties_children[0]
    refute_nil schema.reference
    assert_nil schema.reference.uri
    assert_equal "#/definitions/app", schema.reference.pointer
    refute_nil schema.parent
  end

  it "errors on non-string ids" do
    local_data = data.dup
    local_data["id"] = 4
    e = assert_raises(RuntimeError) { @parser.parse(local_data) }
    assert_equal %{Expected "id" to be of type "String"; value was: 4.},
      e.message
  end

  it "errors on non-string titles" do
    local_data = data.dup
    local_data["title"] = 4
    e = assert_raises(RuntimeError) { @parser.parse(local_data) }
    assert_equal %{Expected "title" to be of type "String"; value was: 4.},
      e.message
  end

  it "errors on non-string descriptions" do
    local_data = data.dup
    local_data["description"] = 4
    e = assert_raises(RuntimeError) { @parser.parse(local_data) }
    assert_equal %{Expected "description" to be of type "String"; value was: 4.},
      e.message
  end

  it "errors on non-array and non-string types" do
    local_data = data.dup
    local_data["type"] = 4
    e = assert_raises(RuntimeError) { @parser.parse(local_data) }
    assert_equal %{Expected "type" to be of type "Array/String"; value was: 4.},
      e.message
  end

  it "errors on unknown types" do
    local_data = data.dup
    local_data["type"] = ["float", "double"]
    e = assert_raises(RuntimeError) { @parser.parse(local_data) }
    assert_equal %{Unknown types: double, float.},
      e.message
  end

  def data
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
            "name" => {
              "description" => "unique name of app",
              "example" => "name",
              "readOnly" => false,
              "type" => [
                "string"
              ]
            },
          },
          "properties" => {
            "app" => {
              "$ref" => "/schemata/app#/definitions/name"
            }
          }
        }
      },
      "properties" => {
        "app" => {
          "$ref" => "#/definitions/app"
        }
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