set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.sensors.elex.be esb-b-test.sensors.elex.be 
}
