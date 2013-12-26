set :stage, :testing

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{ewaf-test.colo.elex.be}
