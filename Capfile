require 'capistrano/setup'
require 'sshkit'

SSHKit.config.command_map =
    {
        :ps         => '/bin/ps',
        :kill       => 'kill',
        :karaf      => '/usr/share/apache-servicemix/bin/start',
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
      # kill all karaf processes on the server
      procs = list_processes
      karaf_procs = procs.find_all { |p| p[:command].include? "karaf" }
      karaf_procs.each do |p|
        as :root do
          execute(:kill, p[:pid])
        end
      end
    end
  end

  task :clean do
    invoke('karaf:stop')
    invoke('cfengine:run')
    on roles(:esb) do
      as "smx-fuse" do
        execute('sudo su smx-fuse -c \'JAVA_OPTS="$JAVA_OPTS -Duser.timezone=CET -server -Xms2048m -Xmx2048m -XX:PermSize=512m -XX:MaxPermSize=512m -XX:+UseParallelOldGC -XX:+CMSClassUnloadingEnabled" /usr/share/apache-servicemix/bin/start clean\'')
      end
      puts "Sleeping for 20 secs to allow servicemix to start."
      sleep 20
    end
  end
end

