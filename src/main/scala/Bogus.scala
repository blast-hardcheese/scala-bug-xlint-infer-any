object Bogus {
  Option.empty[String].contains(1234) // Emits a warning

  def should(func: => Unit): Unit = func

  should {
    Option.empty[String].contains(1234) // Does not warn
  }

  // https://github.com/scalatest/scalatest/issues/2056#issuecomment-902858522
  def shouldAny(func: => Any): Unit = func
  shouldAny {
    Option.empty[String].contains(1234) // Does not warn
  }

  println(Option.empty[String].contains(1234)) // does not warn
}
