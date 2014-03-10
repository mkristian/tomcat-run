require 'tomcat_run/pom_runner'
module TomcatRun
  class War < PomRunner

    def run( file )
      wardir = File.join( tmpdir, 'war' )
      FileUtils.mkdir_p wardir
      file = File.expand_path( file )
      Dir.chdir wardir do
        `unzip -o #{file}`
      end

      maven.property( 'run.war.dir', File.expand_path( wardir ) )

      maven.options[ '-f' ] = File.join( File.dirname( __FILE__ ), 
                                         'tomcat_pom.rb' )

      maven.exec( "org.apache.tomcat.maven:tomcat#{version}-maven-plugin:run-war-only" )
    end
  end
end
