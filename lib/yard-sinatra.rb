YARD::Templates::Engine.register_template_path(File.join(File.dirname(__FILE__), '../templates'))

require File.join(File.dirname(__FILE__), 'yard/sinatra')
require File.join(File.dirname(__FILE__), 'yard/yard-sinatra/tags')
