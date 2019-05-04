require 'rspec'
require_relative '../model/transaccion.rb'

describe 'Transaccion' do

  let(:transaccion) { Transaccion.new }

  it 'Nueva transaccion debe devolver el transporte' do
    transaccion.transporte = 'c33'
    expect(transaccion.transporte()).to eq 'c33'
  end

  it 'Nueva transaccion debe devolver el monto sin descuentos' do
    transaccion.monto = 10
    expect(transaccion.monto).to eq 10
  end

  it 'Nueva transaccion debe devolver el monto con descuentos' do
    transaccion.monto = 7.5
    expect(transaccion.monto).to eq 7.5
  end

  it 'Nueva transaccion debe devolver la fecha' do
    fecha = Time.new(2018,07,13,15,00,00)
    transaccion.fecha = fecha
    expect(transaccion.fecha).to eq fecha
  end

  it 'Cuando llamo a corresponde descuento con una transaccion fuera del lapso de 2 horas, queda en false' do
    t2 = Transaccion.new('c32', nil, Time.new(2017,07,13,15,00,00))
    transaccion.fecha = Time.new(2018,07,13,15,00,00)
    transaccion.transporte = 'c33'
    expect(transaccion.corresponde_descuento(t2)).to eq false
  end

  it 'Cuando llamo a corresponde descuento con una transaccion dentro del lapso de 2 horas, queda en true' do
    t2 = Transaccion.new('c32', nil, Time.new(2018,07,13,15,00,00))
    transaccion.fecha = Time.new(2018,07,13,15,01,00)
    transaccion.transporte = 'c33'
    expect(transaccion.corresponde_descuento(t2)).to eq true
  end

  it 'Cuando llamo a corresponde descuento con una transaccion dentro del lapso de 2 horas, queda en true' do
    t2 = Transaccion.new('c32', nil, Time.new(2018,07,13,15,00,00))
    transaccion.fecha = Time.new(2018,07,13,17,00,00)
    transaccion.transporte = 'c33'
    expect(transaccion.corresponde_descuento(t2)).to eq true
  end

  it 'Cuando llamo a corresponde descuento con una transaccion fuera del lapso de 2 horas, queda en false' do
    t2 = Transaccion.new('c32', nil, Time.new(2018,07,13,15,00,00))
    transaccion.fecha = Time.new(2018,07,13,17,01,00)
    transaccion.transporte = 'c33'
    expect(transaccion.corresponde_descuento(t2)).to eq false
  end

  it 'Cuando llamo a corresponde descuento con una transaccion dentro del lapso de 2 horas con el mismo transporte, queda en false' do
    t2 = Transaccion.new('c33', nil, Time.new(2018,07,13,15,00,00))
    transaccion.fecha = Time.new(2018,07,13,16,00,00)
    transaccion.transporte = 'c33'
    expect(transaccion.corresponde_descuento(t2)).to eq false
  end
end
