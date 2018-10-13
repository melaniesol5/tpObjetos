import artefactos.*
import tpRolando.*


class HechizoLogo {
	var nombre
	var multiplo
	
	constructor(unNombre,unMultiplo) {
		nombre = unNombre
		multiplo = unMultiplo
	}
	
	method nombre(otroNombre) {
		nombre = otroNombre
	}
	
	method poder() {
		return nombre.size() * multiplo 
	}
	
	method esPoderoso() {
		return self.poder() > 15
	}

    method precio(){
	return self.poder()
   }

object hechizoBasico {
	
	method poder() {
		return 10
	}
	
	method esPoderoso(){
		return false 
	}
    method precio(){
  return 10
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

class LibroDeHechizos {
	var hechizos=[]
	
	method agregarHechizo(hechizo) {
		hechizos.add(hechizo)
	}
	
	method removerHechizo(hechizo) {
		hechizos.remove(hechizo)
	}
	
	method poder() {
		return hechizos.filter({ hechizo => hechizo.esPoderoso() }).sum({ hechizo => hechizo.poder() })
	}
}

/*pregunta2: ¿Que sucede si el libro de hechizos incluye como hechizo al mismo libro de hechiceria?
 * si se incluye a si mismo rompe porque el objeto libroDeHechizos no conoce el mensaje esPoderoso()
*/
