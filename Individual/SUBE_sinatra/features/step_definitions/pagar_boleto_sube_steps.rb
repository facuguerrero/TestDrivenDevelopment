require_relative '../support/env'

Given(/^El pasajero con id (\d+) tiene (\d+)\$ en SUBE$/) do |arg1, arg2|
  body = { "id": arg1, "saldo": arg2.to_f} 
  put '/add', body.to_json, "CONTENT_TYPE" => "application/json"
end

Given(/^El pasajero con id (\d+) tiene \-(\d+)\$ en SUBE$/) do |arg1, arg2|
  body = { "id": arg1, "saldo": -arg2.to_f} 
  put '/add', body.to_json, "CONTENT_TYPE" => "application/json"
end

Given(/^El pasajero con id (\d+) posee tarifa social$/) do |arg1|
  body = { "id": arg1 }
  post '/ts', body.to_json, "CONTENT_TYPE" => "application/json"
end

When(/^El pasajero con id (\d+) paga el boleto de (\d+)\$ en el transporte con id (\w+) con fecha (\d+)\-(\d+)\-(\d+) (\d+):(\d+):(\d+)$/) do |arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9|
  body = { "id": arg1, "monto": arg2.to_f, "transporte": arg3, "y": arg4, "mo": arg5, "d": arg6, "h": arg7, "min": arg8, "s": arg9 } 
  post '/cobrar', body.to_json, "CONTENT_TYPE" => "application/json"
  @resultado = JSON.parse(last_response.body)["result"]
  @saldo = JSON.parse(last_response.body)["saldo"]
end

When(/^El pasajero con id (\d+) paga el segundo boleto de (\d+)\$ en el transporte con id (\w+) con fecha (\d+)\-(\d+)\-(\d+) (\d+):(\d+):(\d+)$/) do |arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9|
  body = { "id": arg1, "monto": arg2.to_f, "transporte": arg3, "y": arg4, "mo": arg5, "d": arg6, "h": arg7, "min": arg8, "s": arg9 } 
  post '/cobrar', body.to_json, "CONTENT_TYPE" => "application/json"
  @resultado2 = JSON.parse(last_response.body)["result"]
  @saldo2 = JSON.parse(last_response.body)["saldo"]
end

Then(/^El boleto es emitido$/) do
  expect(@resultado).to eq true
end

Then(/^El segundo boleto es emitido$/) do
  expect(@resultado2).to eq true
end

Then(/^El boleto no puede ser emitido$/) do
  expect(@resultado).to eq false
end

Then(/^El segundo boleto no puede ser emitido$/) do
  expect(@resultado2).to eq false
end

Then(/^El saldo de la sube con id (\d+) es ([0-9.]+)\$$/) do |arg1, arg2|
  expect(@saldo).to eq arg2.to_f
end

Then(/^El saldo de la sube con id (\d+) es \-([0-9.]+)\$$/) do |arg1, arg2|
  expect(@saldo).to eq -arg2.to_f
end

Then(/^El saldo final de la sube con id (\d+) es ([0-9.]+)\$$/) do |arg1, arg2|
  expect(@saldo2).to eq arg2.to_f
end

Then(/^El saldo final de la sube con id (\d+) es \-([0-9.]+)\$$/) do |arg1, arg2|
  expect(@saldo2).to eq -arg2.to_f
end
