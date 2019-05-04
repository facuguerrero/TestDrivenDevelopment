Feature: Pago de pasaje con tarjeta SUBE

  Scenario: Pasajero tiene suficiente credito en la tarjeta SUBE
    Given El pasajero con id 1 tiene 10$ en SUBE
    When El pasajero con id 1 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    Then El boleto es emitido
    And El saldo de la sube con id 1 es 0$

  Scenario: Pasajero paga el boleto con saldo anticipado en la tarjeta SUBE
    Given El pasajero con id 2 tiene 5$ en SUBE
    When El pasajero con id 2 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    Then El boleto es emitido
    And El saldo de la sube con id 2 es -5$

  Scenario: Pasajero no tiene suficiente credito en tarjeta SUBE
    Given El pasajero con id 3 tiene -25$ en SUBE
    When El pasajero con id 3 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    Then El boleto no puede ser emitido
    And El saldo de la sube con id 3 es -25$


  Scenario: Pasajero con tarifa social tiene suficiente credito en la tarjeta SUBE
    Given El pasajero con id 1 tiene 10$ en SUBE
    And El pasajero con id 1 posee tarifa social
    When El pasajero con id 1 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    Then El boleto es emitido
    And El saldo de la sube con id 1 es 2.5$


  Scenario: Pasajero con tarifa social paga el boleto con saldo anticipado en la tarjeta SUBE
    Given El pasajero con id 4 tiene 5$ en SUBE
    And El pasajero con id 4 posee tarifa social
    When El pasajero con id 4 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    Then El boleto es emitido
    And El saldo de la sube con id 4 es -2.5$


  Scenario: Pasajero con tarifa social no tiene suficiente credito en tarjeta SUBE
    Given El pasajero con id 2 tiene -25$ en SUBE
    And El pasajero con id 2 posee tarifa social
    When El pasajero con id 2 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    Then El boleto no puede ser emitido
    And El saldo de la sube con id 2 es -25$


  Scenario: Pasajero sin tarifa social tiene suficiente credito en la tarjeta SUBE para 2 boletos de distinto transporte en lapso de 2 horas
    Given El pasajero con id 3 tiene 50$ en SUBE
    When El pasajero con id 3 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 3 paga el segundo boleto de 10$ en el transporte con id t1 con fecha 2018-09-16 15:15:00
    Then El boleto es emitido
    And El saldo de la sube con id 3 es 40$
    And El segundo boleto es emitido
    And El saldo final de la sube con id 3 es 35$

  Scenario: Pasajero sin tarifa social tiene credito en la tarjeta SUBE para 1 boleto
    Given El pasajero con id 1 tiene -18$ en SUBE
    When El pasajero con id 1 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 1 paga el segundo boleto de 10$ en el transporte con id t1 con fecha 2018-09-16 15:15:00
    Then El boleto es emitido
    And El saldo de la sube con id 1 es -28$
    And El segundo boleto no puede ser emitido
    And El saldo final de la sube con id 1 es -28$


  Scenario: Pasajero sin tarifa social tiene suficiente credito en la tarjeta SUBE para 2 boletos de distinto transporte fuera del lapso de 2 horas
    Given El pasajero con id 5 tiene 50$ en SUBE
    When El pasajero con id 5 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 5 paga el segundo boleto de 10$ en el transporte con id t1 con fecha 2018-09-16 18:15:00
    Then El boleto es emitido
    And El saldo de la sube con id 5 es 40$
    And El segundo boleto es emitido
    And El saldo final de la sube con id 5 es 30$


  Scenario: Pasajero sin tarifa social tiene suficiente credito en la tarjeta SUBE para 2 boletos del mismo transporte en lapso de 2 horas
    Given El pasajero con id 2 tiene 50$ en SUBE
    When El pasajero con id 2 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 2 paga el segundo boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:10:00
    Then El boleto es emitido
    And El saldo de la sube con id 2 es 40$
    And El segundo boleto es emitido
    And El saldo final de la sube con id 2 es 30$


  Scenario: Pasajero con tarifa social tiene suficiente credito en la tarjeta SUBE para 2 boletos de distinto transporte en lapso de 2 horas
    Given El pasajero con id 1 tiene 50$ en SUBE
    And El pasajero con id 1 posee tarifa social
    When El pasajero con id 1 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 1 paga el segundo boleto de 10$ en el transporte con id t1 con fecha 2018-09-16 15:15:00
    Then El boleto es emitido
    And El segundo boleto es emitido
    And El saldo final de la sube con id 1 es 38.75$


  Scenario: Pasajero con tarifa social tiene credito en la tarjeta SUBE para 1 boleto
    Given El pasajero con id 3 tiene -22$ en SUBE
    And El pasajero con id 3 posee tarifa social
    When El pasajero con id 3 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 3 paga el segundo boleto de 10$ en el transporte con id t1 con fecha 2018-09-16 15:15:00
    Then El boleto es emitido
    And El saldo de la sube con id 3 es -29.5$
    And El segundo boleto no puede ser emitido
    And El saldo final de la sube con id 3 es -29.5$

  Scenario: Pasajero con tarifa social tiene suficiente credito en la tarjeta SUBE para 2 boletos de distinto transporte fuera del lapso de 2 horas
    Given El pasajero con id 4 tiene 50$ en SUBE
    And El pasajero con id 4 posee tarifa social
    When El pasajero con id 4 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 4 paga el segundo boleto de 10$ en el transporte con id t1 con fecha 2018-09-16 18:15:00
    Then El boleto es emitido
    And El saldo de la sube con id 4 es 42.5$
    And El segundo boleto es emitido
    And El saldo final de la sube con id 4 es 35$

  @wip
  Scenario: Pasajero con tarifa social tiene suficiente credito en la tarjeta SUBE para 2 boletos del mismo transporte en lapso de 2 horas
    Given El pasajero con id 1 tiene 50$ en SUBE
    And El pasajero con id 1 posee tarifa social
    When El pasajero con id 1 paga el boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:00:00
    And El pasajero con id 1 paga el segundo boleto de 10$ en el transporte con id c33 con fecha 2018-09-16 15:10:00
    Then El boleto es emitido
    And El saldo de la sube con id 1 es 42.5$
    And El segundo boleto es emitido
    And El saldo final de la sube con id 1 es 35$
