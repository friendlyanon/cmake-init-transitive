#include <string>

#include "transitive/transitive.hpp"

auto main() -> int
{
  exported_class e;
  auto* object = e.name_as_parsed_json();
  json_object* name_object = nullptr;
  json_object_object_get_ex(object, "name", &name_object);
  auto name = std::string(json_object_get_string(name_object));
  json_object_put(object);

  return name == "transitive" ? 0 : 1;
}
