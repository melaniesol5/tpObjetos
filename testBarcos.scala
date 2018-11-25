import org.scalatest.FunSuite

class testBarcos extends FunSuite {
  //------------------------ Piratas ------------------------------------

  val barbaNegra = new Guerrero(20,50)
  barbaNegra.energiaInicial_(100)
  val nails = new Cocinero(60,List("jamon","pimienta"))
  nails.energiaInicial_(100)
  val albino = new Navegante(50)
  albino.energiaInicial_(100)
  jackSparrow.energiaInicial_(500)
  jackSparrow.poderDePelea_(200)
  jackSparrow.inteligencia_(300)
  jackSparrow.ingredientes_(List("ron"))

  val calamardo = new Guerrero(40,20)
  calamardo.energiaInicial_(100)
  val patricio = new Navegante(10)
  patricio.energiaInicial_(90)
  val bobEsponja = new Cocinero(100,List("cangreburguer","salsa tartara"))
  bobEsponja.energiaInicial_(100)
  val holandesVolador = new Guerrero(150,90)
  holandesVolador.energiaInicial_(200)

  //------------------------ Barcos ------------------------------------
  val perlaNegra = new Barco(70,80,5,List(barbaNegra,nails,albino,jackSparrow),null,null)
  val shanghaied = new Barco(80,50,7,List(calamardo,patricio,bobEsponja,holandesVolador),null,null)


  test("Elegir un capitan para el Perla Negra") {
    perlaNegra.elegirCapitan()
    assert(perlaNegra.capitan == jackSparrow)
  }

  test("Elegir un capitan para el Shanghaied") {
    shanghaied.elegirCapitan()
    assert(shanghaied.capitan == holandesVolador)
  }

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
    assert(perlaNegra.poderDeFuego == 140)
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

class testBarcosAtaque extends testBarcos{

  test("Hacer que el Perla Negra ataque al Shanghaied") {
    perlaNegra.atacarA(shanghaied)
    assert(perlaNegra.tripulacion.length == 5)
    assert(shanghaied.resistencia == 0)
    assert(shanghaied.poderDeFuego == 0)
    assert(shanghaied.municiones == 0)
    assert(shanghaied.tripulacion.isEmpty)
    assert(shanghaied.capitan == null)
  }
}
