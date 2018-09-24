import artefactos.*
import tpRolando.*

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