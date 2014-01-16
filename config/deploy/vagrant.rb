set :stage, :vagrant

role :esb, %w{192.168.1.10 192.168.1.11 192.168.1.12 192.168.1.13}

set :ssh_options, {
        user: 'jenkins',
        paranoid: false
}

server '192.168.1.20',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }

server '192.168.1.21',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }

server '192.168.1.22',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }

server '192.168.1.23',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }
