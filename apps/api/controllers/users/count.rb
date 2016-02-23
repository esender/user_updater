module Api::Controllers::Users
  class Count
    include Api::Action
    expose :count_hash

    def call(params)
      count = UserRepository.empty_shard_id.count
      @count_hash = { count: count }
    end
  end
end
