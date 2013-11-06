# Define custom tags

YARD::Tags::Library.define_tag("Request", :request, :with_title_and_text)
YARD::Tags::Library.define_tag("Response", :response, :with_types)
YARD::Tags::Library.define_tag("Headers", :header, :with_name)
YARD::Tags::Library.define_tag("Response codes", :response_code, :with_name)
YARD::Tags::Library.define_tag("Image", :image)
YARD::Tags::Library.define_tag("Overall", :overall)
YARD::Tags::Library.define_tag("Data Hash", :data,:with_options)


YARD::Tags::Library.define_tag 'API Resource Name', :api_resource_name
YARD::Tags::Library.define_tag 'API Resource Name', :api_resource_description
YARD::Tags::Library.define_tag 'API Resource Object', :api_resource_object
YARD::Tags::Library.define_tag 'API Response Format', :api_response_format
YARD::Tags::Library.define_tag 'API Response Object', :api_response_object
YARD::Tags::Library.define_tag 'API Response Object Attribute', :service_attr
