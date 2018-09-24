import tpRolando.*
import hechizos.*

object espadaDelDestino {
	var nivelDeLucha = 3

	method nivelDeLucha(unPersonaje){
	return nivelDeLucha
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

}	
	
object mascaraOscura{
				
method nivelDeLucha(unPersonaje){
	return 4.max(fuerzaOscura.valor()/2)
	}
}
	
object armadura{
	
	var nivelDeLucha=2
	
	var refuerzo
	
	method refuerzo(unRefuerzo){refuerzo=unRefuerzo}
	
	method nivelDeLucha(unPersonaje){
		
			return nivelDeLucha + refuerzo.unidadesDeLucha(unPersonaje)
	
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
		return unPersonaje.asignarHabilidadAEspejo()	
	}
}
	