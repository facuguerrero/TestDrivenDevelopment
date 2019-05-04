class Tarjeta
  
  attr_accessor :transaccion
  attr_accessor :id
  attr_accessor :saldo
  attr_accessor :tarifa_social
  attr_reader :id
  attr_reader :saldo

  def initialize(id = nil, saldo = nil, tarifa_social = false)
    @id = id
    @saldo = saldo
    @anticipo = 30
    @tarifa_social = tarifa_social
    @transacciones = Array.new
  end

  def cobrar(transporte, monto, fecha)
    pago = agregar_transaccion(transporte, monto, fecha) ? monto*0.5 : monto
    pago = (@tarifa_social) ? pago*0.75 : pago
    if (pago > @saldo + @anticipo)
      return false
    end
    @saldo = @saldo - pago
    return true
  end

  def agregar_transaccion(transporte, monto, fecha)
    transaccion = Transaccion.new(transporte, monto, fecha)
    anterior = @transacciones.last
    corresponde = anterior ? transaccion.corresponde_descuento(anterior) : false
    @transacciones[@transacciones.length] = transaccion
    return corresponde
  end

  def limpiar()
    @transacciones = Array.new
    @tarifa_social = false
  end

end
