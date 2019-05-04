require 'rspec'
require_relative '../model/tarjeta.rb'

describe 'Tarjeta' do

  let(:tarjeta) { Tarjeta.new }

  it 'Nueva tarjeta con id 0 debe devolver id 0' do
    tarjeta.id = 0
    expect(tarjeta.id).to eq 0
  end

  it 'Nueva tarjeta con id 1 debe devolver id 1' do
    tarjeta.id = 1
    expect(tarjeta.id).to eq 1
  end

  it 'Cobrar 10$ a una tarjeta con saldo de 10$ debe devolver true y el saldo ser 0' do
    tarjeta.id = 2
    tarjeta.saldo = 10
    expect(tarjeta.cobrar(33, 10, Time.new(2018, 07, 16, 15, 00, 00))).to eq true
    expect(tarjeta.saldo).to eq 0
  end

  it 'Cobrar 10$ a una tarjeta con saldo de 15$ debe devolver true y el saldo ser 5' do
    tarjeta.id = 3
    tarjeta.saldo = 15
    expect(tarjeta.cobrar(33, 10, Time.new(2018, 07, 16, 15, 00, 00))).to eq true
    expect(tarjeta.saldo).to eq 5
  end

  it 'Cobrar 10$ a una tarjeta con saldo de 5$ con anticipo de 30 debe devolver true y el saldo ser -5$' do
    tarjeta.id = 4
    tarjeta.saldo = 5
    expect(tarjeta.cobrar(33, 10, Time.new(2018, 07, 16, 15, 00, 00))).to eq true
    expect(tarjeta.saldo).to eq -5
  end

  it 'Cobrar 10$ a una tarjeta con saldo de 10$ y tarifa social, debe devolver true y el saldo ser 2.5$' do
    tarjeta.id = 5
    tarjeta.saldo = 10
    tarjeta.tarifa_social = true
    expect(tarjeta.cobrar(33, 10, Time.new(2018, 07, 16, 15, 00, 00))).to eq true
    expect(tarjeta.saldo).to eq 2.5
  end

  it 'Cobrar 10$ a una tarjeta con saldo de -22$ y tarifa social, debe devolver true y el saldo ser -29.5$' do
    tarjeta.id = 6
    tarjeta.saldo = -22
    tarjeta.tarifa_social = true
    expect(tarjeta.cobrar(33, 10, Time.new(2018, 07, 16, 15, 00, 00))).to eq true
    expect(tarjeta.saldo).to eq -29.5
  end

  it 'Cobrar 2 pasajes de 10$ en un lapso menor a 2 horas con saldo inicial 45$, deja el saldo en 30$' do
    tarjeta.id = 7
    tarjeta.saldo = 45
    expect(tarjeta.cobrar(33, 10, Time.new(2018, 07, 16, 15, 00, 00))).to eq true
    expect(tarjeta.saldo).to eq 35
    expect(tarjeta.cobrar(32, 10, Time.new(2018, 07, 16, 15, 10, 00))).to eq true
    expect(tarjeta.saldo).to eq 30
  end

end
