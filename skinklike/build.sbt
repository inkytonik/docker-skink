name := "skinklike"

version := "1.0"

enablePlugins(BuildInfoPlugin)
buildInfoKeys := Seq[BuildInfoKey](name, version)
buildInfoPackage := "au.edu.mq.comp.skink"

scalaVersion := "2.12.8"

val compilerOptions =
    Seq (
        "-deprecation",
        "-feature",
        "-unchecked",
        "-Xcheckinit",
        "-Xlint:-stars-align,_"
    )

scalacOptions := "-Xfatal-warnings" +: compilerOptions

libraryDependencies ++=
    Seq (
        "org.bitbucket.franck44.automat" %% "automat" % "1.2.2-SNAPSHOT",
        "org.bitbucket.inkytonik.kiama" %% "kiama" % "2.3.0-SNAPSHOT",
        "org.bitbucket.inkytonik.kiama" %% "kiama" % "2.3.0-SNAPSHOT" % "test" classifier ("tests"),
        "org.bitbucket.inkytonik.kiama" %% "kiama-extras" % "2.3.0-SNAPSHOT",
        "org.bitbucket.inkytonik.kiama" %% "kiama-extras" % "2.3.0-SNAPSHOT" % "test" classifier ("tests"),
        "org.bitbucket.inkytonik.scalallvm" %% "scalallvm" % "0.2.0-SNAPSHOT",
        "org.bitbucket.franck44.scalasmt" %% "scalasmt" % "2.2.2-SNAPSHOT",
        "org.scalatest" %% "scalatest" % "3.0.5" % "test",
        "org.scalacheck" %% "scalacheck" % "1.14.0" % "test",
        "com.typesafe.scala-logging" %% "scala-logging" % "3.7.2",
        "ch.qos.logback" % "logback-classic" % "1.2.3"
    )

resolvers ++= Seq (
    Resolver.sonatypeRepo ("releases"),
    Resolver.sonatypeRepo ("snapshots")
)

mainClass in assembly := Some ("Main")
