class Chopper

  CONST_NAMES = ['cero', 'uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve']

  def chop(n, array)
    index = array.index(n)
    if (index)
      return index
    else
      return -1
    end
  end

  def sum(array)
    arrayLength = array.length
    if (arrayLength == 0)
      return 'vacio'
    end
    index = 0
    suma = 0
    while index < arrayLength do
      suma = suma + array[index]
      index = index + 1
    end
    if (suma == 100)
      return 'demasiado grande'
    end
    resto = suma % 10
    resultado = (suma - resto)/10
    str = ''
    if (resultado>0)
      str = CONST_NAMES[resultado] + ','
    end
    return str + CONST_NAMES[resto]
  end
end
