set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.sofia.elex.be esb-b-test.sofia.elex.be
}


server '10.35.80.155',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }


server '10.35.80.156',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }

