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

object espectroMalefico {
	
var nombre 
		
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
object libroDeHechizos{
	var hechizos=[]
	
	method agregarHechizo(hechizo){
		hechizos.add(hechizo)
	}
	
	method removerHechizo(hechizo){
		hechizos.remove(hechizo)
	}
	
	method poder(){
		return hechizos.filter({hechizo=>hechizo.esPoderoso()}).sum({hechizo=>hechizo.poder()})
	}
}
/*pregunta2: ¿Que sucede si el libro de hechizos incluye como hechizo al mismo libro de hechiceria?
 * si se incluye a si mismo rompe porque el objeto libroDeHechizos no conoce el mensaje esPoderoso()
 */

