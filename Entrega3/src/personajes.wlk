import hechizos.*
import artefactos.*

class Personaje {
	
var valorDeBaseParaHechiceria = 3
var valorDeBaseParaLucha = 1
var hechizoPreferido
var artefactos = []
var monedas = 100
const cargaMaxima 

constructor(_artefactos){
	artefactos=_artefactos
	hechizoPreferido= hechizoBasico
	cargaMaxima=300
}
constructor(_h, cm){
	hechizoPreferido=_h
	cargaMaxima=cm
}
constructor(){
	hechizoPreferido= hechizoBasico
	cargaMaxima=300
}

	
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
		if((unArtefacto.pesoTotal(self)+ self.cargaAcumulada())< cargaMaxima){
			artefactos.add(unArtefacto)
		}else{
			throw new Exception("No se puede agregar el artefacto")
		}
		
	}
	method cargaAcumulada(){
		return artefactos.map({artefacto=>artefacto.pesoTotal(self)}).sum()
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

class PersonajeNoControlado inherits Personaje{
	var property nivel
	
	constructor(_h,cm,n)=super(_h,cm){
		nivel=n
	}
	constructor(_a,n)=super(_a){
		nivel=n
	}
	constructor(n)=super(){
		nivel=n
	}
	
	override method habilidadParaLaLucha(){
		return super()* nivel.multiplicador()
	}
	
}
object facil{
	method multiplicador(){
		return 1
	}
}
object moderado{
	method multiplicador(){
		return 2
	}
}	
object dificil{
	method multiplicador(){
		return 4
	}
}

