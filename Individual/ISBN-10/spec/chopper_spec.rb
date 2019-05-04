require 'rspec'
require_relative '../model/chopper'

describe 'IsbnChecker' do

  let(:isbn) { IsbnChecker.new }

  it 'checker de un isbn correcto deberia ser 1' do
    expect(isbn.checker("0471958697")).to eq 1
  end

  it 'checker de un isbn con longitud distinta de 10 deberia ser 0' do
    expect(isbn.checker("0471")).to eq 0
  end

  it 'checker de un isbn con longitud 10 pero incorrecto deberia ser 0' do
    expect(isbn.checker("0471958691")).to eq 0
  end

  it 'checker de un isbn incorrecto con X debe ser 0' do
    expect(isbn.checker("135404295X")).to eq 0
  end

  it 'checker de un isbn correcto con X debe ser 1' do
    expect(isbn.checker("155404295X")).to eq 1
  end

  it 'checker de un isbn correcto con x debe ser 1' do
    expect(isbn.checker("155404295x")).to eq 1
  end

  it 'checker de un isbn correcto con espacios deberia ser 1' do
    expect(isbn.checker("0 4 7 1 9 5 8 6 9 7")).to eq 1
  end

  it 'checker de un isbn correcto con guines deberia ser 1' do
    expect(isbn.checker("0-4-7-1-9-5-8-6-9-7")).to eq 1
  end

  it 'checker de un isbn incorrecto con espacios deberia ser 0' do
    expect(isbn.checker("0 4 7 1 9 5 8 6 9 2")).to eq 0
  end

  it 'checker de un isbn correcto con guines deberia ser 0' do
    expect(isbn.checker("0-4-7-1-9-5-8-6-9-2")).to eq 0
  end

  it 'checker de un isbn correcto con espacios y guiones deberia ser 1' do
    expect(isbn.checker("0-4-7 1 9-5 8 6 9 7")).to eq 1
  end

  it 'checker de un isbn incorrecto con espacios y guiones deberia ser 0' do
    expect(isbn.checker("0-4-7 1 9-5 8 6 9 2")).to eq 0
  end

  it 'checker de un isbn con un caracter no valido y longitud distinta de 10 debe ser 0' do
    expect(isbn.checker("a71958697")).to eq 0
  end

  it 'checker de un isbn con un caracter no valido y longitud 10 debe ser 0' do
    expect(isbn.checker("a471958697")).to eq 0
  end

  it 'checker de un isbn con un caracter no valido en medio debe ser 0' do
    expect(isbn.checker("4719?58697")).to eq 0
  end

  it 'checker de un isbn con muchos caracter no valido debe ser 0' do
    expect(isbn.checker("4d7r958697")).to eq 0
  end

  it 'checker de un isbn con un caracter no valido distinto' do
    expect(isbn.checker(".471958697")).to eq 0
  end

  it 'checker de un isbn completamente con caracteres no validos debe ser 0' do
    expect(isbn.checker("a.?¡¿!@}{}")).to eq 0
  end

  it 'checker de un isbn con caracter no valido solo al final debe ser 0' do
    expect(isbn.checker("123456789a")).to eq 0
  end

  it 'checker de un isbn con caracter no valido solo al final debe ser 0' do
    expect(isbn.checker("12345a789x")).to eq 0
  end
end
