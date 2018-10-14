import tpRolando.*
import hechizos.*

class ArmaDeMano {
	var nivelDeLucha = 3
	
	method nivelDeLucha(unPersonaje) {
		return nivelDeLucha
	}
    method precio(unPersonaje){
    return 5 * nivelDeLucha
  }
}


object collarDivino {
	var cantidadDePerlas 
	

	method cantidadDePerlas(unaCantidad){
   		cantidadDePerlas = unaCantidad
  	}

	method nivelDeLucha(unPersonaje){
		return  cantidadDePerlas
	}
    method precio(unPersonaje){
  return 2 * cantidadDePerlas
  }
}


class Mascara {
	var indiceDeOscuridad
	var poderMinimo = 4
	
	constructor(unIndiceDeOscuridad) {
		if (unIndiceDeOscuridad.between(0,1)) {
			indiceDeOscuridad = unIndiceDeOscuridad
		}
		else {
			self.error("Los valores no estan entre el 1 y el 0")
		}
	}
	
	method nivelDeLucha(unPersonaje) {
		return poderMinimo.max(fuerzaOscura.valor() / 2 * indiceDeOscuridad)
	}
	
	method poderMinimo(unValor) {
		poderMinimo = unValor
	}
}
	
class Armadura {
	var nivelDeLucha=2
	var refuerzo
	
	constructor(unRefuerzo) {
		
		refuerzo = unRefuerzo
	}
	
	method refuerzo(){
		return refuerzo
	}
	method refuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}
	
	method nivelDeLucha(unPersonaje) { //es la base de la armadura
			return nivelDeLucha + refuerzo.unidadesDeLucha(unPersonaje)
	}
	method precio(unPersonaje){
		return refuerzo.precio(self, unPersonaje)
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
	method precio(armadura, unPersonaje){
		return unidadesDeLucha/2
	}
}

object bendicion {
	
	method unidadesDeLucha(unPersonaje) {
		return unPersonaje.nivelDeHechiceria()
	}
	method precio(armadura, unPersonaje){
		return ninguno.precio(armadura,unPersonaje)
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
	method precio(armadura, unPersonaje){
		return elHechizo.precio() + ninguno.precio(armadura,unPersonaje)
	}
}

object ninguno {
	
	method unidadesDeLucha(unPersonaje){
		return 0
	}
	method precio(armadura, unPersonaje){
		return 2
	}
}

object espejo {
	
	method nivelDeLucha(unPersonaje){	
		if(unPersonaje.artefactos()==[self]){
			return 0
		}
		return unPersonaje.asignarHabilidadAEspejo()	
	}
   method precio(unPersonaje){
  return 90
  }
}
