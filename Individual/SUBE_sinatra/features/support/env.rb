require 'rspec/expectations'
require 'rspec'
require 'rack/test'
require 'rspec/expectations'
require 'json'
require_relative '../../app'
require_relative '../../model/cobrador_sube.rb'
require_relative '../../model/tarjeta.rb'
require_relative '../../model/transaccion.rb'

include Rack::Test::Methods

def app
   Sinatra::Application
end