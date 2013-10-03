# YARD::Sinatra

This plugin adds [Sinatra](http://sinatrarb.com) routes to [YARD](http://yardoc.org/) output. Additionally, there is a [Swagger](http://github.com/wordnik/swagger-core) template for generating interactive API documentation.

## Usage

Add to your Gemfile:
    
    gem 'yard-sinatra', github: 'sge/yard-sinatra'

Add comments to your routes (well, that's optional):

    require "sinatra/base"
    require "user"
    
    class ExampleApp < Sinatra::Base
    
      # Settings for a given user
      #
      # @param [User] some user
      # @return [Hash] settings for that user
      def settings(some_user)
        raise NotImplementedMethod
      end
      
      # Displays a settings page for the current user
      #
      # @see ExampleApp#settings
      get "/settings" do
        haml :settings, {}, :settings => settings(current_user)
      end
      
      # Error 404 Page Not Found
      not_found do
        haml :'404'
      end
    
    end

The you're ready to go:

    yardoc example_app.rb

Old versions of YARD (before 0.6.2) will automatically detect the yard-sinatra plugin and load it. In newer versions you must use the `--plugin yard-sinatra` parameter, or add it to a .yardopts file.

## Markdown Format

To generate Markdown-formatted API documentation:

    yardoc -t api -f markdown

## Swagger

To generate spiffy [Swagger](http://github.com/wordnik/swagger-core) documentation, use:

    yardoc -t swagger

By default, the Swagger documentation will include references to `http://127.0.0.1:9292/` as the base URL for making interactive API calls. You can modify this behavior by setting the `API_URL` environment variable, for example:

    API_URL='http://api.domain.com/' yardoc -t swagger

Additionally, you can pass a `CODE_ENV` environment variable with a pointer to a Ruby file which loads your code's environment (classes, models, etc.) YARD will look for `ActiveRecord::Base` objects that correlate with resource API endpoints in order to automatically generate the schema for them. For example:

    CODE_ENV='./lib/environment' yardoc -t swagger

**Note**: you'll need a *real* webserver serving the documentation for all the swagger-ui stuff to work correctly.

## Other use cases

As with yard, this can be used for other means besides documentation.
For instance, you might want a list of all routes defined in a given list of files without executing those files:

    require "yard/sinatra"
    YARD::Registry.load Dir.glob("lib/**/*.rb")
    YARD::Sinatra.routes.each do |route|
      puts route.http_verb, route.http_path, route.file, route.docstring
    end

## Thanks

* Ryan Sobol for implementing `not_found` documentation.
* Loren Segal for making it seamlessly work as YARD plugin.
  Well, and for YARD.
