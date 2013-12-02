set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.sensors.elex.be esb-b-test.sensors.elex.be 
              esb-a-test.erfurt.elex.be esb-b-test.erfurt.elex.be
              esb-a-test.sofia.elex.be esb-b-test.sofia.elex.be}
