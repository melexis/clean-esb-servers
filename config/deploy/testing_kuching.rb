set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{esb-a-test.kuching.elex.be esb-b-test.kuching.elex.be
}

role :karaf, %w{10.60.112.35 10.60.112.34}
