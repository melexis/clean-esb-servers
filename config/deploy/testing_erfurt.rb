set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.erfurt.elex.be esb-b-test.erfurt.elex.be
}
