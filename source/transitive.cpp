#include <string>

#include <fmt/core.h>
#include <json-c/json_tokener.h>

#include "transitive/transitive.hpp"

exported_class::exported_class()
    : m_name("transitive")
    , m_json(fmt::format(R"({{"name":"{}"}})", m_name))
{
}

auto exported_class::name() const -> const char*
{
  return m_name.c_str();
}

auto exported_class::name_as_parsed_json() const -> json_object*
{
  return json_tokener_parse(m_json.c_str());
}
