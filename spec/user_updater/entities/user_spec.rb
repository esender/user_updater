require 'spec_helper'

describe User do
  let(:user) { User.new }

  it 'generate shard_id' do
    user.generate_shard_id
    user.shard_id.wont_be :nil?
  end
end
