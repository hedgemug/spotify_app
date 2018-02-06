Rails.application.routes.draw do
  get '/spotify/authorize' => 'spotify#authorize'
  get '/spotify/callback' => 'spotify#callback'
  get '/spotify/tokens' => 'spotify#tokens'
  get '/spotify/profile' => 'spotify#profile'
end
