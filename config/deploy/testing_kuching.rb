set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.kuching.elex.be esb-b-test.kuching.elex.be
}


server '10.60.112.35',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }


server '10.60.112.34',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }

