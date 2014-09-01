set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-uat.erfurt.elex.be esb-b-uat.erfurt.elex.be}
role :cfengine_update, %w{esb-a-uat.erfurt.elex.be esb-b-uat.erfurt.elex.be}


server '10.49.32.177',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }


server '10.49.32.178',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }

