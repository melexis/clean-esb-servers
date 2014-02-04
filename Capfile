require 'capistrano/setup'
require 'capistrano-karaf'
require 'sshkit'

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

# wait_for_smx_to_start - function that blocks till all bundles are active,  and the last one is started
def wait_for_smx_to_start
  # wait so we can ssh to the smx console
  on roles(:karaf) do
  # wait until all bundles are started and spring context is loaded"
    wait_for_all_bundles timeout=180, sleeptime=10 do 
      |b| ["Active", "Resolved", "Installed"].include? b["status"] 
    end
    wait_for_bundle timeout=180, sleeptime=10 do |b| 
      b["name"] == "Apache CXF Bundle Jar" and b["context"] == 'Started'              
    end
  end
end

# karaf_started? - verify if karaf is listening to its ssh port
def karaf_started?
  on roles(:esb) do
    as "smx-fuse" do
      n = capture('netstat -ao | grep 8101 | wc -l')
      n.to_i > 0
    end
  end
end

# block_till_karaf_started - wait till the karaf server is listening to its ssh port
def block_till_karaf_started (args={})
  args = {:timeout => 60, :sleeptime => 1}.merge(args)
  timeout = Time.now + args[:timeout]
  until (karaf_started? || timeout < Time.now) do
      sleep args[:sleeptime]
  end
end

def block_till_everything_is_started
  block_till_karaf_started
  sleep 20
  wait_for_smx_to_start      
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
      
      # Give karaf a chance to start
      block_till_everything_is_started
    end
  end

  task :start do
    on roles(:esb) do
      as "smx-fuse" do
        execute('sudo su smx-fuse -c \'. /etc/default/smx-fuse; /usr/share/apache-servicemix/bin/start\'')
      end
    end

    # Give karaf a chance to start
    block_till_everything_is_started
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
