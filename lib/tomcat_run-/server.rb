require 'tomcat_run/pom_runner'
module TomcatRun
  class Server < PomRunner

    def copy_config_ru
      basedir = File.expand_path( web_inf )
        .sub( /#{File.expand_path( '.' )}./, '' )
        .gsub( /[^\/]+/, '..' )  
      FileUtils.cp( 'config.ru', web_inf )   
      begin
        unless File.exists?( File.join( web_inf, 'lib' ) )
          FileUtils.ln_s( File.join( basedir, 'lib' ),
                          File.join( web_inf, 'lib' ) )
        end
      rescue
        File.open( File.join( web_inf, 'init.rb' ), 'w' ) do |f|
          f.puts "$LOAD_PATH.push File.expand_path( File.join( '#{basedir}', 'lib' ) )"
        end
      end
    end

    def run
      copy_webxml( rails? ? 'web-development.xml' : 'web.xml' )
      copy_config_ru unless rails?

      maven.options[ '-f' ] = File.join( File.dirname( __FILE__ ), 
                                         'tomcat_pom.rb' )
      maven.exec( 'initialize',
                  "org.apache.tomcat.maven:tomcat#{version}-maven-plugin:run" )
    end
  end
end
