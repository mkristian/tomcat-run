require 'tomcat_run/pom_runner'
module TomcatRun
  class Server < PomRunner

    def copy_config_ru
      return unless web_inf
      FileUtils.cp( 'config.ru', web_inf )        
    end
  
    def run
      copy( 'web.xml' )
      copy( 'init.rb' )
      copy_config_ru
      
      maven.property( 'tomcat.version', version )
      
      exec( :initialize,
            'dependency:unpack',
            "org.apache.tomcat.maven:tomcat#{version}-maven-plugin:run" )
    end

  end
end
