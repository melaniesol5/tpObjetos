import hechizos.*
import artefactos.*

class Personaje {
	
var valorDeBaseParaHechiceria = 3
var valorDeBaseParaLucha = 1
var hechizoPreferido
var artefactos = []
var monedas = 100
	
    method comprar(algo){
    	if(self.leAlcanza(algo)){
    		if(algo.soyHechizo()){
    		monedas-=0.max(algo.precio()-hechizoPreferido.precio()/2)
		   	self.hechizoPreferido(algo)
		   	}else{
		   		self.agregarArtefacto(algo)
		    monedas-=algo.precio()
		   	}
    	}else{
    		self.error("no tiene suficientes monedas")
        }
    
    }
    
    method leAlcanza(algo){
    	if(algo.soyHechizo()){
    		return self.monedas() >= algo.precio() / 2
    	}
    	return self.monedas() >= algo.precio()
    }

    method artefactos() {
    	return artefactos
    }
	method valorDeBaseParaHechiceria(unaCantidad) {
		valorDeBaseParaHechiceria = unaCantidad
	}
	
	method valorDeBaseParaLucha(unaCantidad) {
		valorDeBaseParaLucha = unaCantidad
	}
		
    method hechizoPreferido(){
		return hechizoPreferido
    }
	method hechizoPreferido(unHechizo) {
		hechizoPreferido = unHechizo
	}

    method monedas(){
    	return monedas
    }
	method monedas(unasMonedas){
     monedas = unasMonedas
    }
    
    method modificarMonedas(unaCantidad){
    	monedas = monedas + unaCantidad
    }

	method nivelDeHechiceria() {
		return (valorDeBaseParaHechiceria * hechizoPreferido.poder() ) + fuerzaOscura.valor()	
	}
	
	method seCreePoderoso() {
		return hechizoPreferido.esPoderoso()
	}
	
	method agregarArtefacto(unArtefacto) {
		artefactos.add(unArtefacto)
	}

	method removerArtefacto(unArtefacto) {
		artefactos.remove(unArtefacto)
	}

	method removerTodosLosArtefactos() {
		artefactos.clear()
	}

	method habilidadParaLaLucha() {
		return valorDeBaseParaLucha + artefactos.sum({ artefacto => artefacto.nivelDeLucha(self) })	
	}

	method tieneMayorHabilidadDeLuchaQueNivelDeHechiceria() {
		return self.habilidadParaLaLucha() > self.nivelDeHechiceria()
	}

	method laMejorPertenencia() {
		return artefactos.map({ artefacto => artefacto.nivelDeLucha(self) }).max()
	}
	
	method cantidadDeArtefactos() {
		return artefactos.size()
	}

	method estaCargado() {
		return self.cantidadDeArtefactos() >= 5

	}	
	
	method asignarHabilidadAEspejo(){
	self.removerArtefacto(espejo)
    var nivel =self.laMejorPertenencia()
    self.agregarArtefacto(espejo)
    return nivel
}	
  method cumplirObjetivo(){
		monedas = monedas + 10
	}
	
}
	
