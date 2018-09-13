// PARTE 1

object rolando {
	
var valorDeBaseParaHechiceria = 3 
	var valorDeBaseParaLucha = 1
	var hechizoPreferido = espectroMalefico
	var artefactos = [espadaDelDestino,collarDivino,mascaraOscura]
	

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

method habilidadParaLaLucha(){
	
	 return valorDeBaseParaLucha + artefactos.sum{artefacto =>artefacto.nivelDeLucha(self)}
	
}

method tieneMayorHabilidadDeLuchaQueNivelDeHechiceria(){
	return self.habilidadParaLaLucha() > self.nivelDeHechiceria()
}

method laMejorPertenencia(){
	 artefactos.map({artefacto=>artefacto.nivelDeLucha(self)}).max()
	
	}
method cantidadDeArtefactos(){
	return artefactos.size()
}				
}

object espectroMalefico {
	
var nombre = "espectro malefico"
	
	
 method nombre(unNombre){
 	nombre = unNombre
 }
 method poder() {
 	return nombre.size()
 }

 
 method esPoderoso(){
 	return nombre.size() > 15 
 	
 }		
	
}

object hechizoBasico {

	
	method poder() {
	return 10
	}
	method esPoderoso(){
		return false 
	}
	
}

object fuerzaOscura {
	var valor = 5
	
	method valor() {
		return valor
	}
	method valor(unValor) {
		valor = unValor
	}
	method eclipse(){
		valor *= 2
	}
}

object espadaDelDestino {
	var nivelDeLucha = 3

	method nivelDeLucha(unPersonaje){
	return nivelDeLucha
	}
	
	}
	
	
	
object collarDivino {
	var cantidadDePerlas = 5
	

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
	var refuerzo= bendicion
	method refuerzo(unRefuerzo){refuerzo=unRefuerzo}
	
	
	method nivelDeLucha(unPersonaje){
		if(refuerzo== "ninguno"){
			return nivelDeLucha
		}else{
			return nivelDeLucha+ refuerzo.unidadesDeLucha(unPersonaje)
		}
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
	
	method unidadesDeLucha(unPersonaje){
		return unPersonaje.hechizoPreferido().poder()
	}
	
}

object espejoFantastico{
	var nivelDeLucha=0
	method nivelDeLucha(unPersonaje){
		return 0
		/*if(unPersonaje.cantidadDeArtefactos()==1){
			return 0
		}else{
		return unPersonaje.laMejorPertenencia()}
	}*/
}

}