set :stage, :local

server 'esb-a-test.sensors.elex.be', 
    user: 'jenkins',
    roles: %w{esb},
    ssh_options: {
        keys: %w(/tmp/id_rsa),
        paranoid: false
    }
