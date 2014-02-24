set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{ewaf-test.colo.elex.be}
role :cfengine_update, %w{ewaf-test.colo.elex.be}

server '10.32.240.49',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'smx',
          port: 8101,
          paranoid: false
        }
