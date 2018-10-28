import hechizos.*

class Artefacto{
	var peso
	var fechaDeCompra
	const fechaHoy=new Date()
	method pesoTotal(unPersonaje){
		return peso-self.factorDeCorreccion()
	}
	method factorDeCorreccion(){
		return 1.min(self.diasDesdeCompra()/1000)
	}
	method diasDesdeCompra(){
		return fechaHoy - fechaDeCompra
	}
}
class ArmaDeMano inherits Artefacto {
    method nivelDeLucha(unPersonaje) {
    	return 3
    }
    method precio() {
    	return 5 * 3
    }
    
    method soyHechizo() {
   	return false;
   }
   override method pesoTotal(unPersonaje)= 0
}

object collarDivino inherits Artefacto{
     var cantidadDePerlas
     method cantidadDePerlas(unaCantidad) {
     	cantidadDePerlas = unaCantidad
     }

     method nivelDeLucha(unPersonaje) {
	return  cantidadDePerlas
     }
    
     method precio() {
  	return 2 * cantidadDePerlas
     }
     
     method soyHechizo() {
   	return false;
   }
   override method pesoTotal(unPersonaje)= super(unPersonaje)+0.5*cantidadDePerlas
}


class Mascara inherits Artefacto{
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
	
	method soyHechizo() {
   		return false;
   	}
   	override method pesoTotal(unPersonaje){
   		
   	if(indiceDeOscuridad != 0){
			return super(unPersonaje) + 0.max(self.nivelDeLucha(unPersonaje)-3) 
		}
		return super(unPersonaje)
	}
}
	
class Armadura inherits Artefacto{
	var valorDeBase=2
	var refuerzo
	
	
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
	
	
	method soyHechizo() {
   		return false;
   	}
   	override method pesoTotal(unPersonaje){
   		return refuerzo.peso()
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
	method peso()=1
}

object bendicion {
	
	method unidadesDeLucha(unPersonaje) {
		return unPersonaje.nivelDeHechiceria()
	}
	method precio(armadura){
		return armadura.valorDeBase()
	}
	method peso()=0
}

class Hechizo {
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
	method esPar(){
		return elHechizo.poder().even()
	}
	method peso(){
		if(self.esPar()){
			return 2
		}
		return 1
	}
}

object ninguno {
	
	method unidadesDeLucha(unPersonaje){
		return 0
	}
	method precio(armadura){
		return armadura.valorDeBase()
	}
	method peso()=0
}

object espejo inherits Artefacto{
     method nivelDeLucha(unPersonaje){	
	  if(unPersonaje.artefactos()==[self]){
		return 0
	  }
	    return unPersonaje.asignarHabilidadAEspejo()	
      }
     method precio(){
     	return 90
     }
     method soyHechizo(){
     	return false
     }
     override method pesoTotal(unPersonaje)=0
}
