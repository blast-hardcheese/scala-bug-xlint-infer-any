crossScalaVersions := Seq(
  "2.10.4",
  "2.10.7",
  "2.11.0",
  "2.11.10",
  "2.11.12",
  "2.12.10",
  "2.13.4",
  "3.0.0",
)

scalacOptions ++= Seq(
  "-Xfatal-warnings",
  "-unchecked",
  "-deprecation"
) ++ (scalaVersion.value match {
  case scala3 if scala3.startsWith("3.") => None  // Dotty does not seem to have a way to enable this explicitly
  case _                                 => Some("-Xlint")
})
