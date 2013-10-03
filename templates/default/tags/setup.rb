def init
  super
  sections[:index].push(:header)
  sections[:index].push(:request_field)
  sections[:index].push(:response_field)
  sections[:index].push(:data)
  sections[:index].push(:response_code)
  sections[:index].push(:request)
  sections[:index].push(:response)
end

def data
  data_tag :data
end

def param
  if object.type == :route then tag(:param) else super end
end

def header
  generic_tag :header
end

def request_field
  generic_tag :request_field
end

def response_field
  generic_tag :response_field
end

def response_code
  generic_tag :response_code
end

def data_tag(name, opts = nil)
  return unless object.has_tag?(name)
  opts ||= options_for_tag(name)
  @no_names = true if opts[:no_names]
  @no_types = true if opts[:no_types]
  @name = name
  out = erb('data')
  @no_names, @no_types = nil, nil
  out
end

def generic_tag(name, opts = {})
  return unless object.has_tag?(name)
  @no_names = true if opts[:no_names]
  @no_types = true if opts[:no_types]
  @name = name
  out = erb('generic_tag')
  @no_names, @no_types = nil, nil
  out
end
