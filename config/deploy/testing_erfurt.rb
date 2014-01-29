set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.erfurt.elex.be esb-b-test.erfurt.elex.be
}



server '10.49.32.177',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }


server '10.49.32.178',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }

