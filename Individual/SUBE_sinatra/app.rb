require 'sinatra'
require 'json'
require './model/cobrador_sube'

cobrador = CobradorSUBE.new

put '/add' do
  content_type :json
  input = JSON.parse(request.body.read)
  { :result => cobrador.crear_sube(input['id'], input['saldo']) }.to_json
end

post '/cobrar' do
  content_type :json
  input = JSON.parse(request.body.read)
  fecha = Time.new(input['y'], input['mo'], input['d'], input['h'], input['min'], input['s'])
  { :result => cobrador.cobrar_pasaje(input['id'], input['transporte'], input['monto'], fecha),
    :saldo => cobrador.tarjetas[input['id']].saldo }.to_json
end

post '/ts' do
  content_type :json
  input = JSON.parse(request.body.read)
  cobrador.tarjetas[input['id']].tarifa_social = true
end