require_relative '../support/env'

Given(/^El pasajero con id (\d+) tiene (\d+)\$ en SUBE$/) do |arg1, arg2|
  @cobrador = CobradorSUBE.new
  @cobrador.crear_sube(arg1,arg2.to_f)
end

Given(/^El pasajero con id (\d+) tiene \-(\d+)\$ en SUBE$/) do |arg1, arg2|
  @cobrador = CobradorSUBE.new
  @cobrador.crear_sube(arg1, -arg2.to_f)
end

Given(/^El pasajero con id (\d+) posee tarifa social$/) do |arg1|
  @cobrador.tarjetas[arg1].tarifa_social = true
end

When(/^El pasajero con id (\d+) paga el boleto de (\d+)\$ en el transporte con id (\w+) con fecha (\d+)\-(\d+)\-(\d+) (\d+):(\d+):(\d+)$/) do |arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9|
  @resultado = @cobrador.cobrar_pasaje(arg1, arg3, arg2.to_f, Time.new(arg4, arg5, arg6, arg7, arg8, arg9))
  @saldo = @cobrador.tarjetas[arg1].saldo
end

When(/^El pasajero con id (\d+) paga el segundo boleto de (\d+)\$ en el transporte con id (\w+) con fecha (\d+)\-(\d+)\-(\d+) (\d+):(\d+):(\d+)$/) do |arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9|
  @resultado2 = @cobrador.cobrar_pasaje(arg1, arg3, arg2.to_f, Time.new(arg4, arg5, arg6, arg7, arg8, arg9))
  @saldo2 = @cobrador.tarjetas[arg1].saldo
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
  expect(@cobrador.tarjetas[arg1].saldo).to eq -arg2.to_f
end

Then(/^El saldo final de la sube con id (\d+) es ([0-9.]+)\$$/) do |arg1, arg2|
  expect(@saldo2).to eq arg2.to_f
end

Then(/^El saldo final de la sube con id (\d+) es \-([0-9.]+)\$$/) do |arg1, arg2|
  expect(@saldo2).to eq -arg2.to_f
end
