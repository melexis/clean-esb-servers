set :stage, :prod

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{ewaf.colo.elex.be}
