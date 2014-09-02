set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-uat.kuching.elex.be esb-b-uat.kuching.elex.be
}


server 'esb-a-uat.kuching.elex.be',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }


server 'esb-b-uat.kuching.elex.be',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }

