class CobradorSUBE
  
  attr_accessor :tarjetas
  attr_accessor :tarjeta

  def initialize()
    @tarjetas = Hash.new
  end

  def crear_sube(id_tarjeta, saldo)
    #Si la tarjeta no existe la creamos.
    #Si existe la obtenemos.
    sube = @tarjetas[id_tarjeta]
    if (sube == nil)
      sube = Tarjeta.new(id_tarjeta, saldo)
    end
    #cambiar el funcionamiento de esto
    sube.saldo = saldo
    sube.limpiar
    @tarjetas[id_tarjeta] = sube
    return true
  end

  def cobrar_pasaje(id, transporte, monto, fecha)
    sube = @tarjetas[id]
    return (sube != nil) ? sube.cobrar(transporte, monto, fecha) : false
  end

end
