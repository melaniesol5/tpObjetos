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
		if(refuerzo== null){
			return nivelDeLucha
		}else{
			return nivelDeLucha+ refuerzo.unidadesDeLucha(unPersonaje)
		}
	}
	
	}