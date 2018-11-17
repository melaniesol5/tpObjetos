import piratas.*

class Barco {
	var resistencia
	var poderDeFuego
	var municiones
	var tripulacion
	var capitan = null
	var bando
	
	constructor(unaResistencia,unPoderDeFuego,cantidadDeMuniciones,listaDeTripulacion,unBando) {
		resistencia = unaResistencia
		poderDeFuego = unPoderDeFuego
		municiones = cantidadDeMuniciones
		tripulacion = listaDeTripulacion
		bando = unBando
	}
	
	method dispararCanionazos(cantidadDeCanionazos,otroBarco) {
		if(self.tieneSuficienteMuniciones(cantidadDeCanionazos)) {
			otroBarco.disminuirResistencia(50)
			otroBarco.disminuirTripulacion()
			self.disminuirMuniciones(cantidadDeCanionazos)
		}
		else {
			self.error("El barco no posee suficientes municiones para atacar...")
		}
	}
	
	method tieneSuficienteMuniciones(cantidadDeCanionazos) {
		return municiones - cantidadDeCanionazos >= 0
	}
	
	method disminuirMuniciones(unaCantidad) {
		municiones -= unaCantidad
	}
	
	method disminuirResistencia(unValor) {
		resistencia -= unValor
	}
	
	method disminuirTripulacion() {
		tripulacion = self.tripulacion().filter({ unTripulante => unTripulante.energia() > 20 })
	}
	
	method enftrentarBarco(unBarco) {
		if(self.fuerza() > unBarco.fuerza()) {
			unBarco.herirTripulantes()
			self.sumarTripulacion(unBarco)
			unBarco.desolarse()
		}
		else {
			self.herirTripulantes()
			unBarco.sumarTripulacion(self)
			self.desolarse()
		}
	}
	
	method desolarse() {
		resistencia = 0
		municiones = 0
		poderDeFuego = 0
		tripulacion = []
		capitan = null
	}
	
	method herirTripulantes() {
		self.tripulacion().forEach({ unTripulante => unTripulante.seHirio(0.5)})
	}
	
	method sumarTripulacion(unBarco) {
		tripulacion = self.tripulacion() + unBarco.tripulacion().filter({ unTripulante => unTripulante.poderDeMando() > 100 })
	}
	
	method fuerza() {
		return self.poderDeMandoDeLaTripulacion()
	}
	
	method poderDeMandoDeLaTripulacion() {
		return self.tripulacion().map({ unTripulante => unTripulante.poderDeMando() }).sum()
	}
	
	method elegirCapitan() {
		capitan = self.tripulanteConMasPoderDeMando()
	}
	
	method capitan() {
		return capitan
	}
	
	method tripulacion() {
		return tripulacion
	}
	
	method tripulanteConMasPoderDeMando() {
		return self.tripulacion().sortedBy({ unTripulante,otroTripulante => unTripulante.poderDeMando() > otroTripulante.poderDeMando() }).head()
	}
	
	method aumentarMuniciones(unValor) {
		municiones =+ unValor
	}
	
	method aumentarPoderDeFuego(unValor) {
		poderDeFuego += unValor
	}
	
	method duplicarTripulacion() {
		tripulacion = self.tripulacion() + self.tripulacion()
	}
	
	method cambiarDeBando(unBando) {
		bando = unBando
	}
	
	method aplicarBonus() {
		bando.bonus(self)
	}
	
	method municiones() {
		return municiones
	}
	
	method resistencia() {
		return resistencia
	}
	
	method bando() {
		return bando
	}
}
