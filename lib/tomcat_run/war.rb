require 'tomcat_run/pom_runner'
require 'zip/zip'
module TomcatRun
  class War < PomRunner

    def clean?
      false
    end

    def warfile
      ( Dir[ '*.war' ] + Dir[ File.join( work_dir, '*.war' ) ] ).first
    end

    def wardir( file )
      File.join( work_dir, 'wars', File.basename( file ) )
    end

    def unzip( file, dest )
      FileUtils.rm_rf( dest )
      Zip::ZipFile.open( file ) do |zip_file|
        zip_file.each do |f|
          path = File.join( dest, f.name)
          FileUtils.mkdir_p( File.dirname( path ) )
          zip_file.extract( f, path )
        end
      end
    end

    def run( file = nil )
      file ||= warfile
      raise 'no war file found' unless file
      raise "#{file} does not exists" unless File.exists?( file )
      file = File.expand_path( file || warfile )
      dir = wardir( file )
      FileUtils.mkdir_p( dir )
      unzip( file, dir )

      maven.property( 'tomcat.version', version )
      maven.property( 'tomcat.war.dir', File.expand_path( dir ) )

      exec "org.apache.tomcat.maven:tomcat#{version}-maven-plugin:run-war-only"
    end
  end
end
