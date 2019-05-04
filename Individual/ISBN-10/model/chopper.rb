class IsbnChecker

  def checker(string)
    string.delete! ' '
    string.delete! '-'
    if (string.length != 10)
      return 0
    end

    position = 0
    result = 0
    while position < 9 do
      if (string[position].ord < 48 || 57 < string[position].ord)
        return 0
      end
      value = string[position].to_i
      position = position + 1
      parcial = value * position
      result = result + parcial
    end

    moduleResult = result % 11
    if ((moduleResult == 10 && ('X' == string[position] || 'x' == string[position])) || moduleResult == string[position].to_i)
      return 1
    end
    return 0
  end
end
