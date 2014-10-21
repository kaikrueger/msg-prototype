require 'net/http'

namespace :batch do
  desc 'Batch Tasks'

  task aggregate: :environment do

    uri = URI('http://localhost:3000/aggregate')
    req = Net::HTTP.get(uri)
    puts req
  end
end
