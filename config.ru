# cat config.ru
require "roda"

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect "/hello"
    end

    # /hello branch
    r.on "hello" do
      # Set variable for all routes in /hello branch
      @greeting = 'Hello'

      # /hello request
      r.is do
        # GET /hello request
        r.get do
          "#{@greeting} world! Env: #{ENV['ENVIRONMENT']}"
        end
      end
    end
  end
end

run App.freeze.app
