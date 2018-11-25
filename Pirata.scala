import scala.util.Random

abstract class Pirata() {
  var _energiaInicial = 0

  def poderDeMando(): Double

  def seHirio(unValor : Double): Unit

  def disminuirEnergia(unValor : Int): Unit = {
    _energiaInicial -= unValor
  }

  def tomarRonConJackSparrow(): Unit = {
    this.disminuirEnergia(50)
  }

  def energiaInicial_(unValor: Int):Unit = {
    _energiaInicial = unValor
  }

  def energiaInicial: Int = _energiaInicial

}

class Guerrero(var poderDePelea: Double, var vitalidad: Double) extends Pirata{

  override def poderDeMando(): Double = {
    poderDePelea * vitalidad
  }

  override def seHirio(unValor : Double): Unit = {
    poderDePelea *= unValor
  }
}

class Navegante(var inteligencia: Double) extends Pirata {

  override def poderDeMando(): Double = {
    inteligencia * inteligencia
  }

  override def seHirio(unValor: Double): Unit = {
    inteligencia *= unValor
  }

}

class Cocinero(var moral: Double, var listaDeIngredientes: List[String]) extends Pirata {

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
  var _poderDePelea : Double = 0
  var _inteligencia : Double = 0
  var _ingredientes = List("")

  override def poderDeMando(): Double = {
    _poderDePelea * _inteligencia * _energiaInicial
  }

  override def seHirio(unValor: Double): Unit = {
    _poderDePelea *= unValor
    _inteligencia *= unValor
  }

  def tomarRonCon(unPirata : Pirata): Unit = {
    this.aumentarEnergia(100)
    unPirata.tomarRonConJackSparrow()
  }

  def aumentarEnergia(unValor : Int): Unit = {
    _energiaInicial += unValor
  }

  def recibirIngrediente(unIngrediente : String): Unit = {
    _ingredientes = unIngrediente :: _ingredientes
  }

  //Setter
  def poderDePelea_(unValor: Double): Unit = {
    _poderDePelea = unValor
  }

  //Getter
  def poderDePelea: Double = _poderDePelea

  //Setter
  def inteligencia_(unValor: Double): Unit = {
    _inteligencia = unValor
  }

  //Getter
  def inteligencia: Double = _inteligencia

  //Setter
  def ingredientes_(unaLista: List[String]): Unit = {
    _ingredientes = unaLista
  }

  //Getter
  def ingredientes: List[String] = _ingredientes

}

class Humanoide(var poderDePelea: Double) extends Pirata {

  override def poderDeMando(): Double = {
    _energiaInicial * poderDePelea
  }

  override def seHirio(unValor: Double): Unit = {
    poderDePelea *= unValor
  }

}

//----------------------------------------------------------------------------------------------------------------------
// Clase Barco
//----------------------------------------------------------------------------------------------------------------------

class Barco(var resistencia: Int, var poderDeFuego: Int, var municiones: Double, var tripulacion: List[Pirata], var capitan: Pirata, var bando: Bando) {

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
    otroBarco.poderDeFuego = 0
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
    tripulacion = tripulacion.filter(unPirata => unPirata._energiaInicial > 20)
  }

  def aumentarPoderDeFuego(unValor : Int): Unit = {
    poderDeFuego += unValor
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
// Interfaz Bandos
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
