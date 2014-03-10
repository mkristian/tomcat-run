#
# Copyright (C) 2014 Christian Meier
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require 'thor'
require 'tomcat_run/war'
require 'tomcat_run/server'
module TomcatRun
  class Cli < Thor

    desc 'war [WARFILE]', 'run a given war file'
    method_option :tmpdir, :type => :string, :default => 'pkg'
    method_option :port, :type => :numeric, :default => 8080
    method_option :sslport, :type => :numeric, :default => 8443, :desc => 'ssl port. 0 means no ssl. the server cert is a self-signed cert for localhost (not 127.0.0.1 or ::1) and the browser might call it untrusted.'
    method_option :version, :type => :string, :default => '7', :desc => 'major tomcat version, 7 or 6'
    method_option :verbose, :type => :boolean, :default => false
    method_option :debug, :type => :boolean, :default => false
    def war( file = nil )
      file ||= Dir[ '*.war' ].first
      raise 'no warfile found' unless file
      TomcatRun::War.new( options ).run( file )
    end

    desc 'server', 'run application from filesystem'
    long_desc 'if there is no web.xml in filesystem a web.xml will be copied to public/WEB-INF for further customizations.'
    method_option :tmpdir, :type => :string, :default => 'pkg'
    method_option :publicdir, :type => :string, :default => 'public'
    method_option :port, :type => :numeric, :default => 8080
    method_option :sslport, :type => :numeric, :default => 8443, :desc => 'ssl port. 0 means no ssl. the server cert is a self-signed cert for localhost (not 127.0.0.1 or ::1) and the browser might call it untrusted.'
    method_option :version, :type => :string, :default => '7', :desc => 'major tomcat version, 7 or 6'
    method_option :verbose, :type => :boolean, :default => false
    method_option :debug, :type => :boolean, :default => false
    def server
      TomcatRun::Server.new( options ).run
    end

    desc 'default', 'will scand for warfile or just start the server', :hide => true
    method_option :tmpdir, :type => :string, :default => 'pkg'
    method_option :publicdir, :type => :string, :default => 'public'
    method_option :port, :type => :numeric, :default => 8080
    method_option :sslport, :type => :numeric, :default => 8443
    method_option :version, :type => :string, :default => '7'
    method_option :verbose, :type => :boolean, :default => false
    method_option :debug, :type => :boolean, :default => false
    def default
      file = Dir[ '*.war' ].first
      if file
        puts "found warfile #{file}"
        TomcatRun::War.new.run( file )
      else
        puts 'run application from filesystem'
        server
      end
    end
  end
end
