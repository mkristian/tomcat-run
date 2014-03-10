require 'war_pack/dumper'
module TomcatRun
  class Dump  < WarPack::Dumper

    # overwrite method from Dumper
    def pom_file
      File.join( File.dirname( __FILE__ ), 'tomcat_pom.rb' )
    end
  end
end
