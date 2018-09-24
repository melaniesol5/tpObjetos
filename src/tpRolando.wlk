import hechizos.*
import artefactos.*

object rolando {
	
var valorDeBaseParaHechiceria = 3 
	var valorDeBaseParaLucha = 1
	var hechizoPreferido 
	var artefactos = []
	
    method artefactos(){
    	return artefactos
    }
	method valorDeBaseParaHechiceria(unaCantidad){
		valorDeBaseParaHechiceria = unaCantidad
	}
	
	method valorDeBaseParaLucha(unaCantidad){
		valorDeBaseParaLucha = unaCantidad
		}
		
	method hechizoPreferido(unHechizo){
		hechizoPreferido = unHechizo
		
	}
	
	method nivelDeHechiceria(){
	return (valorDeBaseParaHechiceria * hechizoPreferido.poder() ) + fuerzaOscura.valor()	
	}
	
	method seCreePoderoso() {
		return hechizoPreferido.esPoderoso()
	}
	
method agregarArtefacto(unArtefacto){
	artefactos.add(unArtefacto)
}

method removerArtefacto(unArtefacto){
	artefactos.remove(unArtefacto)
}

method removerTodosLosArtefactos(){
	artefactos.clear()
}

method habilidadParaLaLucha(){
	 return valorDeBaseParaLucha + artefactos.sum{artefacto =>artefacto.nivelDeLucha(self)}	
}

method tieneMayorHabilidadDeLuchaQueNivelDeHechiceria(){
	return self.habilidadParaLaLucha() > self.nivelDeHechiceria()
}

method laMejorPertenencia(){
	 return artefactos.map({artefacto=>artefacto.nivelDeLucha(self)}).max()
	}
	
method cantidadDeArtefactos(){
	return artefactos.size()
}

method estaCargado(){
	return self.cantidadDeArtefactos()>=5
}				
}



object cotaDeMalla{
	var unidadesDeLucha=1
	
	method unidadesDeLucha(unPersonaje){
		return unidadesDeLucha
	}
}
object bendicion{
	
	method unidadesDeLucha(unPersonaje){
		return unPersonaje.nivelDeHechiceria()
	}
}

object hechizo{
	var elHechizo
	
	method elHechizo(unHechizo){elHechizo=unHechizo}
	
	method unidadesDeLucha(unPersonaje){
		return elHechizo.poder()
	}
}

object ninguno {
	
	method unidadesDeLucha(unPersonaje){
		return 0
	}
}


object espejoFantastico{
	var nivelDeLucha
	
	method nivelDeLucha(unPersonaje){	
		if(unPersonaje.artefactos()==[self]){
			return 0
		}
		unPersonaje.removerArtefacto(self)
		nivelDeLucha = unPersonaje.laMejorPertenencia()
		unPersonaje.agregarArtefacto(self)
		return nivelDeLucha
		
	}
}
