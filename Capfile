require 'capistrano/setup'
require 'capistrano-karaf'
require 'sshkit'

smx_console = "sshpass -p smx ssh -oStrictHostKeyChecking=no smx@localhost -p 8101 "

# TODO: find another method to execute these commands in the remote smx-console
SSHKit.config.command_map[:features_addurl] = smx_console + 'features:addurl'
SSHKit.config.command_map[:features_removeurl] = smx_console + 'features:removeurl'
SSHKit.config.command_map[:features_refreshurl] = smx_console + 'features:refreshurl'
SSHKit.config.command_map[:features_install] = smx_console + 'features:install'
SSHKit.config.command_map[:features_uninstall] = smx_console + 'features:uninstall'
SSHKit.config.command_map[:features_list] = smx_console + 'features:list'
SSHKit.config.command_map[:features_info] = smx_console + 'features:info'
SSHKit.config.command_map[:headers] = smx_console + 'headers'
SSHKit.config.command_map[:list] = smx_console + 'osgi:list'
SSHKit.config.command_map[:log_set] = smx_console + 'log:set'
SSHKit.config.command_map[:stop] = smx_console + 'osgi:stop'
SSHKit.config.command_map[:start] = smx_console + 'osgi:start'


SSHKit.config.command_map[:ps] = '/bin/ps'
SSHKit.config.command_map[:kill] = 'kill -9'
SSHKit.config.command_map[:karaf] = '/usr/share/apache-servicemix/bin/start'
SSHKit.config.command_map[:stopsmx] = '/usr/share/apache-servicemix/bin/stop; true;'
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

def karaf_stop (sleeptime = 10)
  # stop servicemix
  on roles(:esb) do
    as "smx-fuse" do
      execute(:stopsmx)
    end
  end  
  sleep sleeptime
  force_stop
end

def wait_for_smx_to_start
  # wait until all bundles are started and spring context is loaded"
  sleep 20

  on roles(:esb) do
    wait_for_all_bundles timeout=180, sleeptime=10 do |b| ["Active", "Resolved", "Installed"].include? b["status"] end
    wait_for_bundle timeout=180, sleeptime=10 do |b| 
      b["name"] == "Apache CXF Bundle Jar" and b["context"] == 'Started'              
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
    karaf_stop
    invoke('karaf:startclean')
    karaf_stop
    invoke('karaf:start')
  end

  task :startclean do
    on roles(:esb) do
      as "smx-fuse" do
        execute('sudo su smx-fuse -c \'. /etc/default/smx-fuse; /usr/share/apache-servicemix/bin/start clean\'')
      end
      wait_for_smx_to_start      
    end
  end

  task :start do
    on roles(:esb) do
      as "smx-fuse" do
        execute('sudo su smx-fuse -c \'. /etc/default/smx-fuse; /usr/share/apache-servicemix/bin/start\'')
      end
    end
    wait_for_smx_to_start
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

before "karaf:clean", "cfengine:run"
before "karaf:install_platform", "karaf:install_eventstore"
