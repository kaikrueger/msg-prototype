require 'net/http'

namespace :batch do
  desc 'Batch Tasks'

  task aggregate: :environment do

    puts 'Aggregating sensors...'

    uri = URI('http://localhost:3000/aggregate')

    if Net::HTTP.get(uri)
      puts 'Successfully Completed.'
    else
      puts 'Aggregation Failed.'
    end
  end
end
