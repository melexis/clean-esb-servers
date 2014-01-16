set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.colo.elex.be esb-b-test.colo.elex.be 
}
