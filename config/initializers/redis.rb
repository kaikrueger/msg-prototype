$redis_server1 = Redis.new(:host => 'redis-server1', :port => 6379)
$redis_server2 = Redis.new(:host => 'redis-server2', :port => 6379)

def get_redis_node(user_id)

  case user_id % 2
    when 0
      $redis_server1
    else
      $redis_server2
  end
end

def clear_all_redis_data

  $redis_server1.flushall
  $redis_server2.flushall
end
