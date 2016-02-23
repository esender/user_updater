require 'spec_helper'

describe UserRepository do
  let(:repository) { UserRepository }
  let(:entity) { User }
  let(:empty_shard_id_entries) do
    3.times.map do |_|
      repository.create(entity.new)
    end
  end
  let(:normal_entry) { repository.create(entity.new(shard_id: 5)) }

  before do
    repository.clear
    empty_shard_id_entries
    normal_entry
  end

  it 'returns only 3 entries' do
    repository.empty_shard_id.entries.size.must_equal 3
  end

  it 'returns last 2 entries' do
    right_array = [empty_shard_id_entries.last, normal_entry]
    repository.start_from(empty_shard_id_entries[1].id).entries.must_equal right_array
  end

  describe 'empty_shard_id_in_batches' do
    it 'raise error' do
      err = -> { repository.empty_shard_id_in_batches }.must_raise
      err.message.must_match /empty_shard_id_in_batches/
    end

    it 'yield 3 times' do
      yields = []
      repository.empty_shard_id_in_batches(batch_size: 1) { |_, num| yields << num }
      yields.must_equal [1, 2, 3]
    end

    it 'returns two array of users' do
      users_arrays = []
      repository.empty_shard_id_in_batches(batch_size: 2) { |users| users_arrays << users }
      users_arrays.map(&:size).must_equal [2, 1]
    end
  end
end
