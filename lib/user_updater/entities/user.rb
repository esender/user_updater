class User
  include Hanami::Entity
  attributes :shard_id

  def generate_shard_id
    @shard_id ||= rand(1..10)
  end
end
