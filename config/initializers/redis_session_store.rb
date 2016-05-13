Rails.application.config.session_store :redis_session_store, {

  key: '4987c8348736b078d8e3ca7c7b9f897ee85cded7330ec219e4e492d36327e0765c976b6365f3f06890abf151c9c012451b6195eba9e9d17cdfffe74bdf29fad2',

  redis: {
    db: 2,
    expire_after: 120.minutes,
    key_prefix: 'micro:session:',
    host: 'localhost:5000', # Redis host name, default is localhost
    port: 6379   # Redis port, default is 6379
  }
}
