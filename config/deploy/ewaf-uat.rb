set :stage, :uat

set :ssh_options, {
    user: 'jenkins',
    paranoid: false
}

role :esb, %w{ewaf-uat.colo.elex.be}
