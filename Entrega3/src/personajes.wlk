import hechizos.*
import artefactos.*

class Personaje {
	
var valorDeBaseParaHechiceria = 3
var valorDeBaseParaLucha = 1
var hechizoPreferido
var artefactos = []
var monedas = 100
const property cargaMaxima 

constructor(_artefactos, m, cm){
	artefactos=_artefactos
	monedas=m
	hechizoPreferido= hechizoBasico
	cargaMaxima=cm
}
constructor(m, cm){
	monedas=m
	hechizoPreferido=hechizoBasico
	cargaMaxima=cm
}
constructor(){
	hechizoPreferido= hechizoBasico
	cargaMaxima=300
}
constructor(a){
	artefactos=a
	hechizoPreferido= hechizoBasico
	cargaMaxima=300
}

	method comprarArtefacto(artefacto){
			self.debitar(artefacto.precio())
			self.agregarArtefacto(artefacto)
	}
	method comprarHechizo(hechizo){
			self.debitar(0.max(hechizo.precio()-hechizoPreferido.precio()/2))
			self.hechizoPreferido(hechizo)
	}
    
    method debitar(unaCantidad){
    	if(monedas>unaCantidad){
    		monedas-=unaCantidad
    	}else{
    		self.error("no tiene suficientes monedas")
    	}
    	
    }
   
	
	method comprarAComerciante(artefacto,comerciante){
		if(self.puedeComprarArtefactoAComerciante(artefacto,comerciante)){
			self.agregarArtefacto(artefacto)
			monedas = monedas - comerciante.precioConImpuesto(artefacto)
		}else{
			throw new Exception("No puede Comprar el artefacto")
		}
	}
	method puedeComprarArtefactoAComerciante(artefacto,comerciante) { 
		return monedas >= comerciante.precioConImpuesto(artefacto)
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
		if((unArtefacto.pesoTotal() + self.cargaAcumulada())< cargaMaxima){
			artefactos.add(unArtefacto)
		}else{
			throw new Exception("No se puede agregar el artefacto")
		}
		
	}
	method cargaAcumulada(){
		return artefactos.map({artefacto=>artefacto.pesoTotal()}).sum()
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
	
	method asignarHabilidadAEspejo(espejo){
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
	
	constructor(a,m,cm,n)=super(a,m,cm){
		nivel=n
	}
	constructor(m,cm,n)=super(m,cm){
		nivel=n
	}
	constructor(a,n)=super(a){
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

class Comerciante{
	var property tipoImpositivo
	method precioConImpuesto(artefacto)=tipoImpositivo.precioConImpuesto(artefacto)
	method recategorizar(){
		tipoImpositivo.recategorizar(self)
	}
}

object comercianteIndependiente{
	var property comision
	method precioConImpuesto(artefacto){
		return self.precioBaseArtefacto(artefacto)*(1 + comision/100)
	}
	method precioBaseArtefacto(artefacto) = artefacto.precio()
	method recategorizar(comerciante){
		if ((comision * 2) > 21 ){
			comerciante.tipoImpositivo(comercianteRegistrado)
		}
		else{
			comision*=2
		}
	}
}

object comercianteRegistrado{
	const iva = 21
	method precioConImpuesto(artefacto){
		return self.precioBaseArtefacto(artefacto)*(1 + iva/100)
	}
	method precioBaseArtefacto(artefacto) = artefacto.precio()
	method recategorizar(comerciante){
		comerciante.tipoImpositivo(comercianteImpuestoALasGanancias)
	}
}

object comercianteImpuestoALasGanancias{
	method precioConImpuesto(artefacto){
		if(artefacto.precio() < minimoNoImponible.minimo()){
			return self.precioBaseArtefacto(artefacto)
		}else{
			return self.precioBaseArtefacto(artefacto) + self.diferenciaImportes(artefacto)*(35/100)
		}	
	}
	method diferenciaImportes(artefacto){
		return (self.precioBaseArtefacto(artefacto)-minimoNoImponible.minimo())
	}
	method precioBaseArtefacto(artefacto) = artefacto.precio()
	method recategorizar(comerciante){}
}

object minimoNoImponible{
	var property minimo
	
}