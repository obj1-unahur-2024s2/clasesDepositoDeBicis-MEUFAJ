class Bicicleta {
  var property rodado //puede cambiar, no dice que queda fijo
  const property largo //no varia
  const property marca
  const property accesorios = []
  
  method altura() = (rodado * 2.5) + 15
  
  method velocidadDeCrucero() = if (largo > 120) rodado + 6 else rodado + 2
  
  method carga() = accesorios.sum({ a => a.carga() })
  
  method peso() = (rodado * 0.5) + accesorios.sum({ a => a.peso() })
  
  method tieneLuz() = accesorios.any({ a => a.esLuminoso() })
  
  method cantAccesoriosLivianos() = accesorios.count({ a => a.peso() < 1 })
  
  method esCompaDe(
    otraBici
  ) = ((otraBici.marca() == self.marca()) and ((otraBici.largo() - self.largo()).abs() <= 10)) and (otraBici != self)
} //el objeto es una clase con un unico elemento

//clase tenes que pensar que hay varios
class Farolito {
  method peso() = 0.5
  
  method carga() = 0
  
  method esLuminoso() = true
}

class Canasto {
  const volumen //raro que cambie el volumen del canasto 
  
  method peso() = volumen * 0.1
  
  method carga() = volumen * 2
  
  method esLuminoso() = false
}

class Morral {
  const largo
  var property tieneOjoDeGato = false
  
  method peso() = 1.2
  
  method carga() = largo / 3
  
  method esLuminoso() = tieneOjoDeGato
}

class Deposito {
  const property bicis = []
  
  method guardarBici(unaBici) {
    bicis.add(unaBici)
  }
  
  method bicisMasRapidas() = bicis.filter({ b => b.velocidadDeCrucero() > 25 })
  
  method marcasDeBicis() = bicis.map({ b => b.marca() }).asSet()
  
  method esNocturno() = bicis.all({ b => b.tieneLuz() })
  
  method tieneBicicletaParaCargar(kg) = bicis.any({ b => b.carga() > kg })
  
  method biciMasRapida() = bicis.max({ b => b.velocidadDeCrucero() })
  //max devuelve el objeto, la bicicleta (no devuelve el objeto transformado, no devuelve la velocidad)
  
  method marcaDeLaBiciMasRapida() = self.biciMasRapida().marca()
  
  method bicisLargas() = bicis.filter({ b => b.largo() > 170 })
  
  method cargaTotalDeBicisLargas() {
    if (!self.bicisLargas().isEmpty()) {
      return self.bicisLargas().sum({ b => b.carga() })
    } else {
      return 0
    }
  }
  
  method bicisSinAccesorios() = bicis.count({ b => b.accesorios().isEmpty() })
  //isEmpty() indica si la lista esta vacia 
  
  method bicisCompasDe(unaBici) = bicis.filter({ b => b.esCompaDe(unaBici) })
  //recorrimos la coleccion e bicis, filtramos y nos quedamos con las bicis del deposito que son compañeras de unaBici
  
  // ¿Qué agregados o cambios deberían hacerse para agregar un nuevo tipo de accesorio? P.ej. el porta-botellitas de agua, un canasto en la parte de atrás, luces para poner en las ruedas.
  //Indicar qué hay que agregar, y qué hay que tocar. Relacionar con los conceptos de "contrato" y/o "polimorfismo". En dos frases, bien cortito.
  // Hay que agregar minimamente: el peso, carga y esLuminoso, para mantener el polimorfismo
  method hayCompanieras() = !bicis.forEach(
    { b => b.bicisCompasDe(b) }
  ).isEmpty()
  
  method parejaDeCompanieras() {
    
  }
}