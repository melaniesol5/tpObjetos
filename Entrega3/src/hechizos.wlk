
class Hechizo {
	var property nombre
	var property multiplo
	
	constructor(_n,_m){
		nombre=_n
		multiplo=_m
	}

	 method poder()
    method precio(){
	return self.poder()
   }
   method esPoderoso(){
   	return self.poder()>15
   }
   
   method soyHechizo() {
   	return true;
   }
}

class HechizoLogo inherits Hechizo{
	
	override method poder(){
		return nombre.size()*multiplo
	}
}
class HechizoComercial inherits Hechizo {

	var property porcentaje
	
	constructor(_n,_m, unPorcentaje)= super(_n,_m){

		porcentaje=unPorcentaje
	}
	method porcentajeDeSuNombre(){
		return nombre.size()*porcentaje/100
	}
	 override method poder() {
		return  multiplo* self.porcentajeDeSuNombre()
	}
	
	
	
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
  
  method soyHechizo() {
   	return true;
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
	method precio(){
		return self.poder() + hechizos.size() *10
	}
	
	method soyHechizo() {
   		return true;
   	}
   	method pesoTotal(unPersonaje)=0
   	
}

/*pregunta2: ¿Que sucede si el libro de hechizos incluye como hechizo al mismo libro de hechiceria?
 * si se incluye a si mismo rompe porque el objeto libroDeHechizos no conoce el mensaje esPoderoso()
*/
