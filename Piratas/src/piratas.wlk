/* ---------------------------- PIRATAS ----------------------------- */

class Pirata {
	
var energiaInicial


constructor(unaEnergiaInicial){
	energiaInicial = unaEnergiaInicial
}

method energiaInicial(){
	return energiaInicial
}	

method poderDeMando()


method aumentarEnergia(unaCantidad) {
	energiaInicial = energiaInicial + unaCantidad
}

method disminuirEnergia(unaCantidad){
	energiaInicial = energiaInicial - unaCantidad
}

method tipo()


}

class Guerrero inherits Pirata {
	
var poderDePelea
var vitalidad

constructor(unaEnergiaInicial,unPoderDePelea,unaVitalidad) = super(unaEnergiaInicial){
	poderDePelea = unPoderDePelea
	vitalidad = unaVitalidad
}

override method poderDeMando(){
	return poderDePelea * vitalidad
}
	
override method tipo(){
	return "guerrero"
}

}

class Navegador inherits Pirata {
	

	
var inteligencia


constructor(unaEnergiaInicial,unaInteligencia) = super(unaEnergiaInicial){
	inteligencia = unaInteligencia
}	

override method poderDeMando(){
	return inteligencia * inteligencia
}	

override  method tipo(){
	return "navegador"
}
}


class Cocinero inherits Pirata {
 
 var moral
 var ingredientes = []
 
 constructor(unaEnergiaInicial,unaMoral,unosIngredientes) = super(unaEnergiaInicial){
	moral = unaMoral
	ingredientes = unosIngredientes
}	
 
 
override method poderDeMando(){
	return moral * self.cantidadDeIngredientes()
}
 
override method tipo(){
	return "cocinero"
} 
 
method cantidadDeIngredientes(){
	return ingredientes.size()
} 

method entregarIngredienteA(unPirata){
	var ingrediente = ingredientes.anyOne()
	unPirata.recibirIngrediente(ingrediente)
	ingredientes.remove(ingrediente)
}
	
}


object jackSparrow inherits Pirata (500) {


	
var poderDePelea 	
var inteligencia
var ingredientes = []


method poderDePelea(unPoderDePelea){
	poderDePelea = unPoderDePelea
	
}
method inteligencia(unaInteligencia){
	inteligencia = unaInteligencia
}

method ingredientes(unosIngredientes){
	ingredientes = unosIngredientes
}


override method poderDeMando(){
	return energiaInicial * poderDePelea * inteligencia 
}	

override method tipo(){
	return "unico"
}

method tomarRonCon(unPirata){
	self.aumentarEnergia(100)
	unPirata.disminuirEnergia(50)
	
	if(unPirata.tipo() == "cocinero"){
	unPirata.entregarIngrediente() 
	}
}

method recibirIngrediente(unIngrediente){
	ingredientes.add(unIngrediente)
}

	
}



/*------------------------------ BARCOS------------------------------------- */


class Barco {
	
var resistencia
var poderDeFuego
var municiones
var tripulantes = []	


method fuerza(){

return tripulantes.sum().map({unTripulante => unTripulante.poderDeMando()})	


}	

method capitanDelBarco() {
	return self.ordenarDeMayorAMenorElPoderDeMando().take(1)
}	

method ordenarDeMayorAMenorElPoderDeMando(){
	return tripulantes.sortedBy({unTripulante, otroTripulante => unTripulante.poderDeMando() > otroTripulante.poderDeMando()})
}

method dispararMunicionesA(cantidad,otroBarco){
	if(municiones - cantidad > 0){
		self.disminuirMuniciones(cantidad)
		otroBarco.disminuirResistencia(50 * cantidad)
	}
	else{
		self.error("No posee la cantidad de munciones suficientes")
	}
	
}


method dismunuirMuniciones(cantidad){
	municiones = municiones - cantidad
}

method disminuirResistencia(unaCantidad){
	resistencia = resistencia - unaCantidad
}

}

