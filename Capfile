
require 'capistrano/setup'
require 'sshkit'

SSHKit.config.command_map =
    {
        :ps         => '/bin/ps',
        :kill       => 'kill -9',
        :karaf      => '/usr/share/apache-servicemix/bin/start',
        :stopsmx    => '/usr/share/apache-servicemix/bin/stop; true;',
        :sleep      => 'sleep',
        :cfagent    => '/usr/sbin/cfagent'
    }

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
    procs = list_processes
    karaf_procs = procs.find_all { |p| p[:command].include? "karaf" }
    karaf_procs.each do |p|
      as "smx-fuse" do
        execute(:kill, p[:pid])
      end
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
    karaf_stop 360
    force_stop
    invoke('cfengine:run')
    invoke('karaf:startclean')
    karaf_stop 30
    puts "Stop and start again"
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

end

