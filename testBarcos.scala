import org.scalatest.FunSuite

class testBarcos extends FunSuite {
  //------------------------ Piratas ------------------------------------
  jackSparrow.ingredientes = "ron" :: jackSparrow.ingredientes
  val barbaNegra = new Guerrero ; barbaNegra.poderDePelea = 20 ; barbaNegra.vitalidad = 50
  val nails = new Cocinero ; nails.energiaInicial = 100 ; nails.moral = 60 ; nails.listaDeIngredientes = "jamon" :: nails.listaDeIngredientes
  val albino = new Navegante ; albino.energiaInicial = 100 ; albino.inteligencia = 50
  val calamardo = new Guerrero ; calamardo.energiaInicial = 100 ; calamardo.poderDePelea = 40 ; calamardo.vitalidad = 20
  val patricio = new Navegante ; patricio.energiaInicial = 90 ; patricio.inteligencia = 10
  val bobEsponja = new Cocinero ; bobEsponja.energiaInicial = 100 ; bobEsponja.moral = 100 ; bobEsponja.listaDeIngredientes = "cangreburguers" :: bobEsponja.listaDeIngredientes
  val holandesVolador = new Guerrero ; holandesVolador.energiaInicial = 200 ; holandesVolador.poderDePelea = 150 ; holandesVolador.vitalidad = 90
  //------------------------ Barcos ------------------------------------
  val perlaNegra = new Barco
  perlaNegra.resistencia = 70
  perlaNegra.municiones = 5
  perlaNegra.poderDefuego = 80
  perlaNegra.tripulacion = List(barbaNegra,nails,albino,jackSparrow)
  val shanghaied = new Barco
  shanghaied.resistencia = 80
  shanghaied.municiones = 7
  shanghaied.poderDefuego = 50
  shanghaied.tripulacion = List(calamardo,patricio,bobEsponja,holandesVolador)


  test("Crear un barco de 4 tripulantes y elegir un capitan") {
    perlaNegra.elegirCapitan()
    assert(perlaNegra.capitan == jackSparrow)
  }
  /*
  test("Hacer que el Perla Negra ataque al Shanghaied") {
    perlaNegra.atacarA(shanghaied)
    assert(shanghaied.resistencia == 0)
    assert(shanghaied.poderDefuego == 0)
    assert(shanghaied.municiones == 0)
    assert(shanghaied.tripulacion.isEmpty)
    assert(shanghaied.capitan == null)
  }
  */
  test("El Perla Negra dispara 7 cañonazos") {
    assertThrows[IllegalArgumentException] {
      perlaNegra.dispararCanionazos(7,shanghaied)
    }
  }

  test("El Perla Negra dispara 1 cañionazos") {
    perlaNegra.dispararCanionazos(1,shanghaied)
    assert(perlaNegra.municiones == 4)
    assert(shanghaied.resistencia == 30) // Deberia ser 30 ya que no tendria que surgir efecto en los test
    assert(shanghaied.tripulacion.length == 4)
  }

  test("Aplicar el bonus que tiene el Perla Negra (esta en el bando union pirata)") {
    perlaNegra.bando = unionPirata
    perlaNegra.aplicarBonus()
    assert(perlaNegra.poderDefuego == 140)
  }

  test("El Perla Negra cambia de bando a la armada inglesa y se aplica el bonus") {
    perlaNegra.bando = armadaInglesa
    perlaNegra.aplicarBonus()
    assert(perlaNegra.municiones == 5.2)
  }

  test("El Perla Negra cambia de bando al holandes errante y se aplica el bonus") {
    perlaNegra.bando = holandesErrante
    perlaNegra.aplicarBonus()
    assert(perlaNegra.tripulacion.length == 8)
  }

}