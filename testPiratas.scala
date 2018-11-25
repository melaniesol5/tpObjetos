import org.scalatest.FunSuite

class testPiratas extends FunSuite {
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


  test("Crear un pirata guerrero y calcular el poder de mando") {
    assert(barbaNegra.poderDeMando() == 1000)
  }

  test("Crear un pirata cocinero y calcular el poder de mando") {
    assert(nails.poderDeMando() == 120)
    assert(nails.cantidadDeIngredientes() == 2)
  }

  test("Crear un pirata navegante y calcular el poder de mando") {
    assert(albino.poderDeMando() == 2500)
  }

  test("Calcular el poder de mando de Jack Sparrow") {
    assert(jackSparrow.poderDeMando() == 30000000)
  }

  test("Hacer que Jack tome ron con un pirata (guerrero / navegante) y aumente su energia en 100 y disminuya en 50 la energia del pirata acompaniante") {
    jackSparrow.tomarRonCon(albino)
    assert(jackSparrow.energiaInicial == 600)
    assert(albino.energiaInicial == 50)
  }

  test("Hacer que Jack tome ron con un pirata cocinero y aumente su energia en 100 y disminuya en 50 la energia del pirata acompaniante") {
    jackSparrow.tomarRonCon(nails)
    assert(jackSparrow.energiaInicial == 700)
    assert(jackSparrow.ingredientes.length == 2)
    assert(nails.energiaInicial == 50)
    assert(nails.cantidadDeIngredientes() == 1)
  }
}
