# frozen_string_literal: true

default_redis_conn = Redis.new
REDIS_CONN = Redis::Namespace.new(Rails.env.to_sym, redis: default_redis_conn)
