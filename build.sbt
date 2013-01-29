seq(samskivert.POMUtil.pomToSettings("pom.xml") :_*)

crossPaths := false

scalaVersion := "2.10.0"

autoScalaLibrary := false // no scala-library dependency

javacOptions ++= Seq("-Xlint", "-Xlint:-serial", "-source", "1.6", "-target", "1.6")

// filter the super-source directory from the build
unmanagedSources in Compile ~= (_.filterNot(_.getPath.indexOf("gwt") != -1))

// add our sources to the main jar file
unmanagedResourceDirectories in Compile <+= baseDirectory / "src/main/java"

// disable doc publishing, SBT seems to confuse javadoc
publishArtifact in (Compile, packageDoc) := false

// allows SBT to run junit tests
libraryDependencies += "com.novocode" % "junit-interface" % "0.7" % "test->default"
