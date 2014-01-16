set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.sofia.elex.be esb-b-test.sofia.elex.be
}
