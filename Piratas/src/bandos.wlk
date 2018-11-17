import barcos.*

class ArmadaInglesa {
	
	method bonus(unBarco) {
		unBarco.aumentarMuniciones(unBarco.municiones() * 0.3)
	}
}

class UnionPirata {
	
	method bonus(unBarco) {
		unBarco.aumentarPoderDeFuego(60)
	}
}

class HolandesErrante {
	
	method bonus(unBarco) {
		unBarco.duplicarTripulacion()
	}
}
