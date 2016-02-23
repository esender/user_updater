class UserRepository
  include Hanami::Repository
  @logger = Hanami::Logger.new('UserRepository')

  def self.empty_shard_id
    query do
      where(shard_id: nil)
        .order(:id)
    end
  end

  def self.start_from(start_id)
    query do
      where{ id > start_id }
    end
  end

  def self.empty_shard_id_in_batches(options = {})
    raise '`empty_shard_id_in_batches` Block must exist!' unless block_given?

    start = options[:start]
    batch_size = options[:batch_size] || 100
    batch_num = 1

    records_with_limit = empty_shard_id.limit(batch_size)
    records = start ? records_with_limit.start_from(start) : records_with_limit

    while records.any?
      entries = records.entries
      records_size = entries.size
      primary_key_offset = entries.last.id

      yield entries, batch_num

      break if records_size < batch_size

      records = records_with_limit.start_from(primary_key_offset)
      batch_num += 1
    end
  end
end
