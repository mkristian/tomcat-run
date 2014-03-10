eval( File.read( java.lang.System.getProperty( "common.pom" ) ) )

config = { :path => '/', 
  :port => '${run.port}',
  :warDirectory => '${run.war.dir}',
  :warSourceDirectory => '${public.dir}',
  :ignorePackaging => true,
  :fork => '${run.fork}',
}
if java.lang.System.getProperty( "tomcat.run.sslport" ).to_s != '0'
  config[ 'httpsPort' ] = '${run.sslport}'
  config[ 'keystoreFile' ] = '${run.keystore}'
  config[ 'keystorePass' ] = '${run.keystore.pass}'
  config[ 'truststorePass' ] = '${run.truststore.pass}'
end
  
plugin( 'org.apache.tomcat.maven:tomcat${tomcat.version}-maven-plugin', '2.2',
        config )
