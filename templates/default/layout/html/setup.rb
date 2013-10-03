def menu_lists
  super + [{:type => "route", :title => "Routes", :search_title => "Route List"}]
end

def javascripts
  super + %w(js/custom.js)
end
