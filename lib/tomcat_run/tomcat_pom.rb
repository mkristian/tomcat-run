eval( File.read( java.lang.System.getProperty( "common.pom" ) ), nil, 
      java.lang.System.getProperty( "common.pom" ) )

config = { :path => '/', 
  :port => '${run.port}', 
  :httpsPort => '${run.sslport}',
  :keystoreFile => '${run.keystore}',
  :keystorePass => '${run.keystore.pass}',
  :truststorePass => '${run.truststore.pass}',
  :warDirectory => '${tomcat.war.dir}',
  :warSourceDirectory => '${public.dir}',
  :ignorePackaging => true,
  :fork => '${run.fork}',
}

plugin( 'org.apache.tomcat.maven:tomcat${tomcat.version}-maven-plugin', '2.2',
        config )
