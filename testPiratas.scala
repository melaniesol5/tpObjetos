import org.scalatest.FunSuite

class testPiratas extends FunSuite {
  val barbaNegra = new Guerrero
  barbaNegra.poderDePelea = 20
  barbaNegra.vitalidad = 50
  val nails = new Cocinero
  nails.energiaInicial = 100
  nails.moral = 60
  nails.listaDeIngredientes = "jamon" :: nails.listaDeIngredientes
  val albino = new Navegante
  albino.energiaInicial = 100
  albino.inteligencia = 50


  test("Crear un pirata guerrero y calcular el poder de mando") {
    assert(barbaNegra.poderDeMando() == 1000)
  }

  test("Crear un pirata cocinero y calcular el poder de mando") {
    assert(nails.poderDeMando() == 60)
    assert(nails.cantidadDeIngredientes() == 1)
  }

  test("Crear un pirata navegante y calcular el poder de mando") {
    assert(albino.poderDeMando() == 2500)
  }

  test("Calcular el poder de mando de Jack Sparrow") {
    jackSparrow.energiaInicial = 500
    assert(jackSparrow.poderDeMando() == 150000)
  }

  test("Hacer que Jack tome ron con un pirata (guerrero / navegante) y aumente su energia en 100 y disminuya en 50 la energia del pirata acompaniante") {
    jackSparrow.tomarRonCon(albino)
    assert(jackSparrow.energiaInicial == 600)
    assert(albino.energiaInicial == 50)
  }

  test("Hacer que Jack tome ron con un pirata cocinero y aumente su energia en 100 y disminuya en 50 la energia del pirata acompaniante") {
    jackSparrow.energiaInicial = 500
    jackSparrow.tomarRonCon(nails)
    assert(jackSparrow.energiaInicial == 600)
    assert(nails.energiaInicial == 50)
  }
}