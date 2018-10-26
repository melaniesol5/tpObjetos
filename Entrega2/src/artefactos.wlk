import tpRolando.*
import hechizos.*

class ArmaDeMano {
    var tipo = "artefacto"
	
    method nivelDeLucha(unPersonaje) {
    	return 3
    }
    
    method precio() {
    	return 5 * 3
    }
    
    method tipo() {
   	return tipo;
   }
}

object collarDivino {
     var cantidadDePerlas
     var tipo = "artefacto"
	
     method cantidadDePerlas(unaCantidad) {
     	cantidadDePerlas = unaCantidad
     }

     method nivelDeLucha(unPersonaje) {
	return  cantidadDePerlas
     }
    
     method precio() {
  	return 2 * cantidadDePerlas
     }
     
     method tipo() {
   	return tipo;
   }
}


class Mascara {
	var indiceDeOscuridad
	var poderMinimo = 4
	var tipo = "artefacto"
	
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
	
	method tipo() {
   		return tipo;
   	}
}
	
class Armadura {
	var valorDeBase=2
	var refuerzo
	var tipo = "artefacto"
	
	constructor(unRefuerzo) {
		
		refuerzo = unRefuerzo
	}
	method valorDeBase(){
		return valorDeBase
	}
	method valorDeBase(valor){
		valorDeBase=valor
	}
	method refuerzo(){
		return refuerzo
	}
	method refuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}
	
	method nivelDeLucha(unPersonaje) { 
			return valorDeBase + refuerzo.unidadesDeLucha(unPersonaje)
	}
	method precio(){
		return refuerzo.precio(self)
	}
	
	method tipo() {
   		return tipo;
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
	method precio(armadura){
		return unidadesDeLucha/2
	}
}

object bendicion {
	
	method unidadesDeLucha(unPersonaje) {
		return unPersonaje.nivelDeHechiceria()
	}
	method precio(armadura){
		return armadura.valorDeBase()
	}
}

class hechizo {
	var elHechizo
	
	method elHechizo(unHechizo){
		elHechizo = unHechizo
	}
	
	method unidadesDeLucha(unPersonaje){
		return elHechizo.poder()
	}
	method precio(armadura){
		return elHechizo.precio() + armadura.valorDeBase()
	}
}

object ninguno {
	
	method unidadesDeLucha(unPersonaje){
		return 0
	}
	method precio(armadura){
		return armadura.valorDeBase()
	}
}

object espejo {
     var tipo = "artefacto"

     method nivelDeLucha(unPersonaje){	
	if(unPersonaje.artefactos()==[self]){
		return 0
	}
	return unPersonaje.asignarHabilidadAEspejo()	
     }
     method precio(){
     	return 90
     }
     
     method tipo() {
   	return tipo;
     }
}
