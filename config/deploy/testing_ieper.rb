set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.sensors.elex.be esb-b-test.sensors.elex.be 
}

server '10.32.16.22',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }


server '10.32.16.23',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }




