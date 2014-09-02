set :stage, :testing

set :ssh_options, {
  user: 'jenkins',
  paranoid: false,
  keys: ['id_rsa_jenkins', "#{Dir.home}/.ssh/id_rsa"]
}

role :esb, %w{esb-a-uat.sensors.elex.be esb-b-uat.sensors.elex.be}
role :cfengine_update, %w{esb-a-uat.sensors.elex.be esb-b-uat.sensors.elex.be}

server '10.32.16.154',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }


server '10.32.16.155',
    user: 'smx',
    roles: %{karaf},
    ssh_options:
        { auth_methods: ["password"],
          password: 'Kon6QuaytUc?',
          port: 8101,
          paranoid: false
        }




