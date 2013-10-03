require 'active_support/all'

def init
  @api_name = ENV['API_NAME'].present? ? ENV['API_NAME'] : File.basename(File.expand_path '.')
  @api_url  = ENV['API_URL'].present? ? ENV['API_URL'] : 'http://127.0.0.1:9292/'
  Templates::Engine.with_serializer('api.md', options.serializer) do
    erb :markdown
  end
end

def controller_or_route_tag(route,tag_name)
  controller_or_route_tags(route,tag_name).first rescue nil
end

def controller_or_route_tags(route,tag_name)
  arr = [ controller_for_route(route).tags(tag_name), route.tags(tag_name) ]
  arr.delete([])
  arr.first
end

def filename_for_route(route)
  "#{route.http_verb.parameterize}_#{route.http_path.parameterize}.html"
end

def object_at(namespace)
  options.objects.each do |obj|
    return obj if "#{obj.namespace}::#{obj.name}".to_s == namespace.to_s
  end
  nil
end

def resource_for_route(route)
  resources.each { |r| return r if routes_for_resource(r).include?(route) }
end

def resource_description(resource)
  controllers_with_defined_resources.each do |c| 
    return c.tag(:api_resource_description).text if c.tag(:api_resource_description).text.present? && c.tag(:api_resource_name).text == resource
  end
  nil
end

def routes_for_resource(r)
  controllers_with_defined_resources.each do |c| 
    return routes_for_controller(c) if c.tag(:api_resource_name).text == r
  end
  YARD::Sinatra.routes.select { |route| route.http_path.split('/')[1] == r }
end

def controllers
  YARD::Sinatra.routes.map { |r| object_at(r.namespace) }.uniq
end

def controller_for_route(route)
  object_at(route.namespace)
end

def controllers_with_defined_resources
  controllers.select { |c| c.tag(:api_resource_name).present? }
end

def routes_for_controller(obj)
  YARD::Sinatra.routes.select { |r| r.namespace.to_s == "#{obj.namespace}::#{obj.name}" }
end

def resources
  resources = []
  controllers_with_defined_resources.each do |c|
    resources << c.tag(:api_resource_name).text
  end
  ( controllers - controllers_with_defined_resources ).each do |c|
    routes_for_controller(c).each do |route|
      resources << route.http_path.split('/')[1]
    end
  end

  resources.uniq
end