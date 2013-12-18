require 'capistrano/setup'
require 'sshkit'

SSHKit.config.command_map =
    {
        :ps         => '/bin/ps',
        :kill       => 'kill',
        :karaf      => '/usr/share/apache-servicemix/bin/start',
        :stopsmx    => '/usr/share/apache-servicemix/bin/stop',
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
  task :stop do
    on roles(:esb) do
      # stop servicemix
      as :root do
        execute(:stopsmx)
      end
    end
  end

  task :forcestop do
    # kill all remaining karaf processes on the server
    procs = list_processes
    karaf_procs = procs.find_all { |p| p[:command].include? "karaf" }
    karaf_procs.each do |p|
      as :root do
          execute(:kill, p[:pid])
      end
    end      
  end
  
  task :clean do
    invoke('karaf:stop')

    # wait 360 seconds to allow smx to shutdown
    as "smx-fuse" do
      execute(:sleep, '360')
    end    

    invoke('karaf:forcestop')
    invoke('cfengine:run')
    invoke('karaf:startclean')
    invoke('karaf:stop')

    # wait 30 seconds to allow smx to shutdown
    as "smx-fuse" do
      execute(:sleep, '30')
    end        
    
    invoke('karaf:forcestop')
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

