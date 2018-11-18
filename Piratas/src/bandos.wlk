import barcos.*

object armadaInglesa {
	
	method bonus(unBarco) {
		unBarco.aumentarMuniciones(unBarco.municiones() * 0.3)
	}
}

object unionPirata {
	
	method bonus(unBarco) {
		unBarco.aumentarPoderDeFuego(60)
	}
}

object holandesErrante {
	
	method bonus(unBarco) {
		unBarco.duplicarTripulacion()
	}
}
