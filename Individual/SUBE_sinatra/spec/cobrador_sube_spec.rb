require 'rspec'
require_relative '../model/cobrador_sube.rb'

describe 'CobradorSUBE' do

  let(:cs) { CobradorSUBE.new }

  it 'Inicializo un cobrador y el metodo crear sube' do
    expect(cs.crear_sube(0, 10)).to eq true
  end

  it 'El cobrador puede inicializar una sube con id' do
    expect(cs.crear_sube(1, 10)).to eq true
    expect(cs.tarjetas[1].id).to eq 1
  end

  it 'El cobrador puede inicializar una sube con id y checkeo de que el saldo sea el correcto' do
    expect(cs.crear_sube(2, 10)).to eq true
    expect(cs.tarjetas[2].id).to eq 2
    expect(cs.tarjetas[2].saldo).to eq 10
  end

  it 'Si se realiza un cobro de 10$ con saldo suficiente debe devolver true' do
    expect(cs.crear_sube(3, 10)).to eq true
    expect(cs.cobrar_pasaje(3, 10, 33, Time.new(2018, 07, 16, 15, 00, 00))).to eq true
  end

  it 'Si realizamos un cobro a una tarjeta que no existe debe devolver false' do
    expect(cs.crear_sube(4, 10)).to eq true
    expect(cs.cobrar_pasaje(12, 10, 33, Time.new(2018, 07, 16, 15, 00, 00))).to eq false
  end

end
