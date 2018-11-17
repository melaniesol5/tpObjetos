/* ---------------------------- PIRATAS ----------------------------- */

class Pirata {
	
var energiaInicial

constructor(unaEnergiaInicial) {
	energiaInicial = unaEnergiaInicial
}

method poderDeMando()

method seHirio()

method energiaInicial() {
	return energiaInicial
}	

method disminuirEnergia(unaCantidad) {
	energiaInicial -= unaCantidad
}

method tipo()


}

class Guerrero inherits Pirata {
	
var poderDePelea
var vitalidad

constructor(unaEnergiaInicial,unPoderDePelea,unaVitalidad) = super(unaEnergiaInicial) {
	poderDePelea = unPoderDePelea
	vitalidad = unaVitalidad
}

override method poderDeMando() {
	return poderDePelea * vitalidad
}
	
override method tipo() {
	return "guerrero"
}

override method seHirio(unValor) {
	poderDePelea *= unValor
}

}

class Navegador inherits Pirata {
	
var inteligencia

constructor(unaEnergiaInicial,unaInteligencia) = super(unaEnergiaInicial){
	inteligencia = unaInteligencia
}	

override method poderDeMando() {
	return inteligencia * inteligencia
}	

override  method tipo() {
	return "navegador"
}

override method seHirio(unValor) {
	inteligencia *= unValor
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

override method seHirio(unValor) {
	moral *= unValor
}

}

object jackSparrow inherits Pirata (500) {
	
var property poderDePelea 	
var property inteligencia
var ingredientes = []

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
	if(unPirata.tipo() == "cocinero") {
		unPirata.entregarIngrediente(self) 
	}
}

method recibirIngrediente(unIngrediente){
	ingredientes.add(unIngrediente)
}

method aumentarEnergia(unaCantidad) {
	energiaInicial = energiaInicial + unaCantidad
}
	
}
