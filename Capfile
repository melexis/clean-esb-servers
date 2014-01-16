require 'capistrano/setup'
require 'capistrano-karaf'
require 'sshkit'

SSHKit.config.command_map[:ps] = '/bin/ps'
SSHKit.config.command_map[:kill] = 'kill -9'
SSHKit.config.command_map[:karaf] = '/usr/share/apache-servicemix/bin/start'
SSHKit.config.command_map[:stopsmx] = '/usr/share/apache-servicemix/bin/stop; true;'
SSHKit.config.command_map[:sleep] = 'sleep'
SSHKit.config.command_map[:cfagent] = '/usr/sbin/cfagent'
SSHKit.config.command_map[:tail_100] = '/usr/bin/tail -100 /usr/share/apache-servicemix/data/log/server.log'

@failed_hostname = nil

def list_processes
    matches = []
    procs = capture(:ps, "ax")
    procs.each_line do |line|
        m = /(?<PID>\d+)[ ]*(?<TTY>[?\w\/\d]+)[ ]*(?<STATUS>[\w\+]+)[ ]*(?<TIME>\d+:\d{1,2}+) (?<COMMAND>.*)/.match(line)
        if m then
            matches.push ({ :pid      => m['PID'],
                            :tty      => m['TTY'],
                            :status   => m['STATUS'],
                            :time     => m['TIME'],
                            :command  => m['COMMAND']
                         })
        end
    end
    matches
end

def force_stop
  # kill all remaining karaf processes on the server
  on roles(:esb) do
    begin 
      procs = list_processes
      karaf_procs = procs.find_all { |p| p[:command].include? "karaf" }
      karaf_procs.each do |p|
        as "smx-fuse" do
          execute(:kill, p[:pid])
        end
      end
    rescue Exception => e
      puts "#{host.hostname} got exception #{e.message}"
      raise e
    end
  end
end

def karaf_stop (sleeptime)
  # stop servicemix
  on roles(:esb) do
    as "smx-fuse" do
      execute(:stopsmx)
    end
  end
  # wait for 360 seconds
  sleep sleeptime
end

def sleep (time)
  on roles(:esb) do
    as "smx-fuse" do
      execute(:sleep, time)
    end    
  end
end

namespace :cfengine do
  task :run do
    on roles(:esb) do
      as :root do
        execute(:cfagent, '-q')
      end
    end
  end
end

namespace :karaf do 
  task :clean do
    force_stop
    invoke('karaf:start')
  end

  task :startclean do
    on roles(:esb) do
      as "smx-fuse" do
        execute('sudo su smx-fuse -c \'JAVA_OPTS="$JAVA_OPTS -Duser.timezone=CET -server -Xms2048m -Xmx2048m -XX:PermSize=512m -XX:MaxPermSize=512m -XX:+UseParallelOldGC -XX:+CMSClassUnloadingEnabled" /usr/share/apache-servicemix/bin/start clean\'')
      end
      puts "Sleeping for 40 secs to allow servicemix to start."
      sleep 40
    end
  end

  task :start do
    on roles(:esb) do
      as "smx-fuse" do
        execute('sudo su smx-fuse -c \'JAVA_OPTS="$JAVA_OPTS -Duser.timezone=CET -server -Xms2048m -Xmx2048m -XX:PermSize=512m -XX:MaxPermSize=512m -XX:+UseParallelOldGC -XX:+CMSClassUnloadingEnabled" /usr/share/apache-servicemix/bin/start\'')
      end
      puts "Sleeping for 40 secs to allow servicemix to start."
      sleep 40
    end
  end

  task :install_eventstore do
    on roles(:karaf) do
      begin
        add_url "mvn:com.melexis.esb/eventstore-feature/1.3-SNAPSHOT/xml/features"
        feature_install "eventstore-service"
      rescue Exception => e
        puts "#{host.hostname} got exception #{e.message}"
        invoke 'karaf:print_log_files'
        raise e
      end
    end
  end

  task :install_platform do
    on roles(:karaf) do
      begin
        add_url "mvn:com.melexis.repository/ewafermap-repo/2.19.1/xml/features"
        feature_install "ewafermap-platform"
      rescue Exception => e
        puts "#{host.hostname} got exception #{e.message}"
        invoke 'karaf:print_log_files'
        raise e
      end
    end
  end

  task :install_ape do
    on roles(:karaf) do
      begin
        add_url "mvn:com.melexis.ape/rasco-feature/1.25-SNAPSHOT/xml/features"
        feature_install "rasco"
        feature_install "rasco-libs"
        feature_install "rasco-svcs"
      rescue Exception => e
        puts "#{host.hostname} got exception #{e.message}"
        invoke 'karaf:print_log_files'
        raise e
      end
    end
  end

  task :install_taskrow do
    on roles(:karaf) do
      begin
        add_url "mvn:com.melexis.repository/exception-handling-repo/2.18.0/xml/features"
        add_url "mvn:com.melexis.repository/taskrow-repo/1.0.1-SNAPSHOT/xml/features"
        feature_install "taskrow"
      rescue Exception => e
        puts "#{host.hostname} got exception #{e.message}"
        invoke 'karaf:print_log_files'
        raise e
      end
    end
  end

  task :verify do
    on roles(:karaf) do
      begin
        spring_osgi_extender = list_bundles.find {|b| b[:name] == 'spring-osgi-extender'}
        raise RuntimeError unless spring_osgi_extender[:status] == 'Active' || spring_osgi_extender[:status] == 'Resolved'
        puts "#{host.hostname}: ok"
      rescue Exception => e
        puts "#{host.hostname} got exception #{e.message}"
        invoke 'karaf:print_log_files'
        raise e
      end
    end
  end

  task :print_log_files do
    on roles(:esb) do
      last_lines = capture(:tail_100)
      puts last_lines.lines.map {|l| "#{host.hostname}: l"}.join("\n")
    end
  end
end

before "karaf:install_platform", "karaf:install_eventstore"
