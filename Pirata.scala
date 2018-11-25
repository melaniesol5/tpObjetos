import scala.util.Random

abstract class Pirata () {
  var energiaInicial = 0

  def poderDeMando(): Double

  def seHirio(unValor : Double): Unit

  def disminuirEnergia(unValor : Int): Unit = {
    energiaInicial -= unValor
  }

  def tomarRonConJackSparrow(): Unit = {
    this.disminuirEnergia(50)
  }
}

class Guerrero extends Pirata {
  var poderDePelea : Double = 0
  var vitalidad : Double = 0

  override def poderDeMando(): Double = {
    poderDePelea * vitalidad
  }

  override def seHirio(unValor : Double): Unit = {
    poderDePelea *= unValor
  }
}

class Navegante extends Pirata() {
  var inteligencia: Double = 0

  override def poderDeMando(): Double = {
    inteligencia * inteligencia
  }

  override def seHirio(unValor: Double): Unit = {
    inteligencia *= unValor
  }

}

class Cocinero extends Pirata() {
  var moral: Double = 0
  var listaDeIngredientes : List[String] = List[String]()

  override def poderDeMando(): Double = {
    moral * listaDeIngredientes.length
  }

  
  override def tomarRonConJackSparrow(): Unit = {
    this.disminuirEnergia(50)
    this.entregarIngredienteA()
  }

  override def seHirio(unValor: Double): Unit = {
    moral *= unValor
  }

  def entregarIngredienteA(): Unit = {
    val ingrediente = listaDeIngredientes(Random.nextInt(listaDeIngredientes.length))
    jackSparrow.recibirIngrediente(ingrediente)
    listaDeIngredientes = listaDeIngredientes.filter( unIngrediente => unIngrediente != ingrediente)
  }

  def cantidadDeIngredientes(): Int = {
    listaDeIngredientes.length
  }
}

object jackSparrow extends Pirata {
  var poderDePelea : Double = 500
  var inteligencia : Double = 300
  var ingredientes = List("")

  override def poderDeMando(): Double = {
    poderDePelea * inteligencia * ingredientes.length
  }

  override def seHirio(unValor: Double): Unit = {
    poderDePelea *= unValor
    inteligencia *= unValor
  }

  def tomarRonCon(unPirata : Pirata): Unit = {
    this.aumentarEnergia(100)
    unPirata.tomarRonConJackSparrow()
  }

  
  def aumentarEnergia(unValor : Int): Unit = {
    energiaInicial += unValor
  }

  def recibirIngrediente(unIngrediente : String): Unit = {
    ingredientes = unIngrediente :: ingredientes
  }
}

class Humanoide extends Pirata {
  var poderDePelea : Double = 0

  override def poderDeMando(): Double = {
    energiaInicial * poderDePelea
  }

  
  override def seHirio(unValor: Double): Unit = {
    poderDePelea *= unValor
  }

}

//----------------------------------------------------------------------------------------------------------------------
// Clase Barco
//----------------------------------------------------------------------------------------------------------------------

class Barco {
  var resistencia = 0
  var poderDefuego = 0
  var municiones: Double = 0
  var tripulacion: List[Pirata] = List[Pirata]()
  var capitan : Pirata = _
  var bando : Bando = _

  def elegirCapitan(): Unit = {
    capitan = tripulacion.maxBy(unPirata => unPirata.poderDeMando())
  }

  def atacarA(otroBarco : Barco): Unit = {
    if( this.fuerzaDelBarco() > otroBarco.fuerzaDelBarco() ) {
      otroBarco.herirTripulacion()
      this.sumarTripulacion(otroBarco)
      this.vaciarBarcoEnemigo(otroBarco)
    }
    else {
      this.herirTripulacion()
      otroBarco.sumarTripulacion(this)
      otroBarco.vaciarBarcoEnemigo(this)
    }
  }

  def fuerzaDelBarco(): Double = {
    tripulacion.map(unPirata => unPirata.poderDeMando()).sum
  }

  def herirTripulacion(): Unit = {
    tripulacion.foreach(unPirata => unPirata.seHirio(0.5))
  }

  def sumarTripulacion(otroBarco : Barco): Unit = {
    tripulacion = tripulacion ::: otroBarco.tripulacion.filter(unPirata => unPirata.poderDeMando() > 100)
  }

  def vaciarBarcoEnemigo(otroBarco: Barco): Unit = {
    otroBarco.resistencia = 0
    otroBarco.municiones = 0
    otroBarco.poderDefuego = 0
    otroBarco.capitan = null
    otroBarco.tripulacion = List()
  }

  def dispararCanionazos(cantidadDeCanionazos : Int , otroBarco : Barco): Unit = {
    if(this.tieneSuficienteMuniciones(cantidadDeCanionazos)) {
      otroBarco.disminuirResistencia(50 * cantidadDeCanionazos)
      otroBarco.eliminarTripulacion()
      this.disminuirMuniciones(cantidadDeCanionazos)
    }
    else {
      throw new IllegalArgumentException("El barco no posee suficientes municiones...")
    }
  }

  def tieneSuficienteMuniciones(cantidadDeCanionazos : Int): Boolean = {
    municiones - cantidadDeCanionazos >= 0
  }

  def disminuirResistencia(unValor : Int): Unit = {
    resistencia -= unValor
    if(resistencia < 0)
      resistencia = 0
  }

  def disminuirMuniciones(unValor : Int): Unit = {
    municiones -= unValor
  }

  def eliminarTripulacion(): Unit = {
    tripulacion = tripulacion.filter(unPirata => unPirata.energiaInicial > 20)
  }

  def aumentarPoderDeFuego(unValor : Int): Unit = {
    poderDefuego += unValor
  }

  def aumentarMuniciones(unValor : Double): Unit = {
    municiones += unValor
  }

  def duplicarTripulacion(): Unit = {
    tripulacion = tripulacion ::: tripulacion
  }

  def aplicarBonus(): Unit = {
    bando.bonus(this)
  }
}

//----------------------------------------------------------------------------------------------------------------------
// Clase Bandos
//----------------------------------------------------------------------------------------------------------------------

trait Bando {
  def bonus(unBarco: Barco): Unit
}


object unionPirata extends Bando {

  override def bonus(unBarco: Barco): Unit = {
    unBarco.aumentarPoderDeFuego(60)
  }
}

object holandesErrante extends Bando {

  override def bonus(unBarco: Barco): Unit = {
    unBarco.duplicarTripulacion()
  }
}

object armadaInglesa extends  Bando {

  override def bonus(unBarco: Barco): Unit = {
    unBarco.aumentarMuniciones(unBarco.municiones * 0.3)
  }
}
