require 'war_pack/pom_runner'
module TomcatRun
  class PomRunner < WarPack::PomRunner

    def version
       @config[ 'version' ] || '7'
    end

    def pom_file
      file( 'tomcat_pom.rb' )
    end

    def file( file )
      File.join( File.dirname( __FILE__ ), file )
    end
  end
end
