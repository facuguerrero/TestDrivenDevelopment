class Transaccion

  attr_accessor :transporte
  attr_accessor :monto
  attr_accessor :fecha
  attr_accessor :descuento
  attr_reader :transporte
  attr_reader :monto
  attr_reader :fecha

  def initialize(transporte = nil, monto = nil, fecha = nil)
    @transporte = transporte
    @monto = monto
    @fecha = fecha
    @descuento = false
  end

  def corresponde_descuento(t2)
    puts @fecha.to_i - t2.fecha.to_i
    @descuento = ((@fecha.to_i - t2.fecha.to_i).abs <= 7200) && (@transporte != t2.transporte) #esta expresado en segundos
    return @descuento
  end

end
