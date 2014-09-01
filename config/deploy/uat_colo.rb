set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-uat.colo.elex.be esb-b-uat.colo.elex.be}
role :cfengine_update, %w{esb-a-uat.colo.elex.be esb-b-uat.colo.elex.be}


server '10.32.241.197',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }


server '10.32.241.198',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }
