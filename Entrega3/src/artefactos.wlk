import hechizos.*

class Artefacto{
	var property peso
	var property fechaDeCompra
	const fechaHoy=new Date()
	
	constructor(_peso,_fechaDeCompra){
		peso=_peso
		fechaDeCompra=_fechaDeCompra
	}
	method pesoTotal(){
		return self.peso()-self.factorDeCorreccion()
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
   
}

object collarDivino {
     var cantidadDePerlas=5
     
     
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
   method pesoTotal()= 0.5 * cantidadDePerlas
}


class Mascara inherits Artefacto{
	var indiceDeOscuridad
	var poderMinimo = 4
	
	
	constructor(_peso,_fechaDeCompra, unIndiceDeOscuridad)=super(_peso,_fechaDeCompra) {
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
   	override method pesoTotal(){
   		
   	if(indiceDeOscuridad != 0){
			return super() + 0.max(self.nivelDeLucha(null)-3) 
		}
		return super()
	}
}
	
class Armadura inherits Artefacto{
	var valorDeBase=2
	var refuerzo
	
	
	constructor(_p,_f,unRefuerzo)=super(_p,_f) {
		
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
   	override method pesoTotal(){
   		return super()+refuerzo.peso()
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

object espejo inherits Artefacto(peso, fechaDeCompra){
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
     
}
