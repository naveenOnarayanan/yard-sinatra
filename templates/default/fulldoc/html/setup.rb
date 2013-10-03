# Generate a searchable route list in the output
def generate_route_list
  # load all the features from the Registry
  @items = Registry.all(:route)
  @list_title = "Route List"
  @list_type = "route"

  # optional: the specified stylesheet class
  # when not specified it will default to the value of @list_type
  @list_class = "class"

  # Generate the full list html file with named route_list.html
  # @note this file must be match the name of the type
  asset("route_list.html", erb(:full_list))
end
