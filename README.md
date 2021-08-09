Infer Any/AnyVal warning suppressed by inclusion in Unit block.
===

Code
---

```scala
object Bogus {
  Option.empty[String].contains(1234) // Emits a warning

  def should(func: => Unit): Unit = func

  should {
    Option.empty[String].contains(1234) // Does not warn
  }

  println(Option.empty[String].contains(1234)) // does not warn
}
```

Description
---

The same line, `Option.empty[String].contains(1234)`, conditionally emits
warnings depending on whether it is contained in a block that returns `Unit`.

Identical -Xlint:infer-any settings across 2.11, 2.12, 2.13 show only one warning, where 2.10.7 correctly reports three warnings.

3.0 does not immediately present an alternative to `-Xlint:infer-any` ([the migration notes just say `X`](https://docs.scala-lang.org/scala3/guides/migration/options-lookup.html)), but included in the output here for completeness.

Compiler results:
---

### 2.10.7
user$ sbtn "++2.10.7; clean; compile"
```
[info] entering *experimental* thin client - BEEP WHIRR
[info] terminate the server with `shutdown`
> ++2.10.7; clean; compile
[info] Setting Scala version to 2.10.7 on 1 projects.
[info] Reapplying settings...
[info] set current project to bug (in build file:/private/tmp/bug/)
[info] compiling 1 Scala source to /private/tmp/bug/target/scala-2.10/classes ...
[error] /private/tmp/bug/src/main/scala/Bogus.scala:2:24: value contains is not a member of Option[String]
[error]   Option.empty[String].contains(1234) // Emits a warning
[error]                        ^
[error] /private/tmp/bug/src/main/scala/Bogus.scala:7:26: value contains is not a member of Option[String]
[error]     Option.empty[String].contains(1234) // Does not warn
[error]                          ^
[error] /private/tmp/bug/src/main/scala/Bogus.scala:10:32: value contains is not a member of Option[String]
[error]   println(Option.empty[String].contains(1234)) // does not warn
[error]                                ^
[error] three errors found
[error] (Compile / compileIncremental) Compilation failed
[error] Total time: 0 s, completed Aug 9, 2021 1:41:03 PM
```

### 2.11.0
user$ sbtn "++2.11.0; clean; compile"
```
[info] entering *experimental* thin client - BEEP WHIRR
[info] terminate the server with `shutdown`
> ++2.11.0; clean; compile
[info] Setting Scala version to 2.11.0 on 1 projects.
[info] Reapplying settings...
[info] set current project to bug (in build file:/private/tmp/bug/)
[info] compiling 1 Scala source to /private/tmp/bug/target/scala-2.11/classes ...
[error] /private/tmp/bug/src/main/scala/Bogus.scala:2:32: a type was inferred to be `Any`; this may indicate a programming error.
[error]   Option.empty[String].contains(1234) // Emits a warning
[error]                                ^
[error] one error found
[error] (Compile / compileIncremental) Compilation failed
[error] Total time: 0 s, completed Aug 9, 2021 1:41:03 PM
```

### 2.11.12
user$ sbtn "++2.11.12; clean; compile"
```
[info] entering *experimental* thin client - BEEP WHIRR
[info] terminate the server with `shutdown`
> ++2.11.12; clean; compile
[info] Setting Scala version to 2.11.12 on 1 projects.
[info] Reapplying settings...
[info] set current project to bug (in build file:/private/tmp/bug/)
[info] compiling 1 Scala source to /private/tmp/bug/target/scala-2.11/classes ...
[error] /private/tmp/bug/src/main/scala/Bogus.scala:2:32: a type was inferred to be `Any`; this may indicate a programming error.
[error]   Option.empty[String].contains(1234) // Emits a warning
[error]                                ^
[error] one error found
[error] (Compile / compileIncremental) Compilation failed
[error] Total time: 0 s, completed Aug 9, 2021 1:41:04 PM
```

### 2.12.10
user$ sbtn "++2.12.10; clean; compile"
```
[info] entering *experimental* thin client - BEEP WHIRR
[info] terminate the server with `shutdown`
> ++2.12.10; clean; compile
[info] Setting Scala version to 2.12.10 on 1 projects.
[info] Reapplying settings...
[info] set current project to bug (in build file:/private/tmp/bug/)
[info] compiling 1 Scala source to /private/tmp/bug/target/scala-2.12/classes ...
[error] /private/tmp/bug/src/main/scala/Bogus.scala:2:24: a type was inferred to be `Any`; this may indicate a programming error.
[error]   Option.empty[String].contains(1234) // Emits a warning
[error]                        ^
[error] one error found
[error] (Compile / compileIncremental) Compilation failed
[error] Total time: 0 s, completed Aug 9, 2021 1:41:04 PM
```

### 2.13.6
user$ sbtn "++2.13.6; clean; compile"
```
[info] entering *experimental* thin client - BEEP WHIRR
[info] terminate the server with `shutdown`
> ++2.13.6; clean; compile
[info] Setting Scala version to 2.13.6 on 1 projects.
[info] Reapplying settings...
[info] set current project to bug (in build file:/private/tmp/bug/)
[info] compiling 1 Scala source to /private/tmp/bug/target/scala-2.13/classes ...
[error] /private/tmp/bug/src/main/scala/Bogus.scala:2:24: a type was inferred to be `Any`; this may indicate a programming error.
[error]   Option.empty[String].contains(1234) // Emits a warning
[error]                        ^
[error] one error found
[error] (Compile / compileIncremental) Compilation failed
[error] Total time: 0 s, completed Aug 9, 2021 1:41:04 PM
```

### 3.0.0
user$ sbtn "++3.0.0; clean; compile"
```
[info] entering *experimental* thin client - BEEP WHIRR
[info] terminate the server with `shutdown`
> ++3.0.0; clean; compile
[info] Setting Scala version to 3.0.0 on 1 projects.
[info] Reapplying settings...
[info] set current project to bug (in build file:/private/tmp/bug/)
[info] compiling 1 Scala source to /private/tmp/bug/target/scala-3.0.0/classes ...
[success] Total time: 0 s, completed Aug 9, 2021 1:41:05 PM
```
