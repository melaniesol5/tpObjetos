import rolando.*
import hechizos.*

class ArmaDeMano {
	var nivelDeLucha = 3
	
	method nivelDeLucha(unPersonaje) {
		return nivelDeLucha
	}
}

object espadaDelDestino inherits ArmaDeMano {
}


object collarDivino {
	var cantidadDePerlas 
	

	method cantidadDePerlas(unaCantidad){
   		cantidadDePerlas = unaCantidad
  	}

	method nivelDeLucha(unPersonaje){
		return  cantidadDePerlas
	}
}


class Mascara {
	var indiceDeOscuridad
	var poderMinimo = 4
	
	constructor(unIndiceDeOscuridad) {
		indiceDeOscuridad = unIndiceDeOscuridad
	}
	
	method nivelDeLucha(unPersonaje) {
		if(self.calculoNivelDeLucha() <= 0) {
			return poderMinimo
		}
		else {
			return self.calculoNivelDeLucha()
		}
	}
	
	method calculoNivelDeLucha() {
		return poderMinimo.max(fuerzaOscura.valor() / 2 * indiceDeOscuridad)
	}
	
	method poderMinimo(unValor) {
		poderMinimo = unValor
	}
}
	
class Armadura {
	var nivelDeLucha
	var refuerzo
	
	constructor(unNivelDeLucha,unRefuerzo) {
		nivelDeLucha = unNivelDeLucha
		refuerzo = unRefuerzo
	}
	
	method refuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}
	
	method nivelDeLucha(unPersonaje) {
			return nivelDeLucha + refuerzo.unidadesDeLucha(unPersonaje)
	}
}

class CotaDeMalla {
	var unidadesDeLucha
	
	constructor (unaUnidadDeLucha) {
		unidadesDeLucha = unaUnidadDeLucha
	}
	
	method unidadesDeLucha(unPersonaje){
		return unidadesDeLucha
	}
}

object bendicion {
	
	method unidadesDeLucha(unPersonaje) {
		return unPersonaje.nivelDeHechiceria()
	}
}

object hechizo {
	var elHechizo
	
	method elHechizo(unHechizo){
		elHechizo = unHechizo
	}
	
	method unidadesDeLucha(unPersonaje){
		return elHechizo.poder()
	}
}

object ninguno {
	
	method unidadesDeLucha(unPersonaje){
		return 0
	}
}


class Espejo {
	var nivel
	
	method nivelDeLucha(unPersonaje) {	
		if(unPersonaje.artefactos()==[self]){
			return 0
		}
		else {
			unPersonaje.removerArtefacto(self)
    		nivel = unPersonaje.laMejorPertenencia()
    		unPersonaje.agregarArtefacto(self)
    		return nivel
		}
	}
}