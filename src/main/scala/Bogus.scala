object Bogus {
  Option.empty[String].contains(1234) // Emits a warning

  def should(func: => Unit): Unit = func

  should {
    Option.empty[String].contains(1234) // Does not warn
  }

  println(Option.empty[String].contains(1234)) // does not warn
}
