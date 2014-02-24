set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false,
    keys: ['id_rsa_jenkins', "#{Dir.home}/.ssh/id_rsa"]
}

role :esb, %w{esb-a-test.sensors.elex.be esb-b-test.sensors.elex.be
              esb-a-test.erfurt.elex.be esb-b-test.erfurt.elex.be
              esb-a-test.sofia.elex.be esb-b-test.sofia.elex.be
              esb-a-test.kuching.elex.be esb-b-test.kuching.elex.be
              esb-a-test.colo.elex.be esb-b-test.colo.elex.be
}


role :cfengine_update, %w{esb-a-test.sensors.elex.be esb-b-test.sensors.elex.be
              esb-a-test.erfurt.elex.be esb-b-test.erfurt.elex.be
              esb-a-test.sofia.elex.be esb-b-test.sofia.elex.be
              esb-a-test.kuching.elex.be esb-b-test.kuching.elex.be
              esb-a-test.colo.elex.be esb-b-test.colo.elex.be
}
