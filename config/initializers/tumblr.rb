CLIENT = Tumblr::Client.new({
:consumer_key => ENV["tumblr_consumer_key"],
:consumer_secret => ENV["tumblr_consumer_secret"],
:oauth_token => ENV["tumblr_oauth_token"],
:oauth_token_secret => ENV["tumblr_oauth_token_secret"]
})
