name := "rv32c"

version := "0.1.0"

organization := "org.rv32c"

scalaVersion := "2.13.14"

val spinalVersion = "1.14.2"

libraryDependencies ++= Seq(
  "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion,
  "com.github.spinalhdl" %% "spinalhdl-lib" % spinalVersion,
  "com.github.spinalhdl" %% "spinalhdl-sim" % spinalVersion,
  "org.scalatest" %% "scalatest" % "3.2.19" % Test,
  compilerPlugin("com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion)
)

Compile / run / fork := true

Test / fork := true

Test / parallelExecution := false

javaOptions ++= Seq("-Xmx2G", "-Xss8M")
