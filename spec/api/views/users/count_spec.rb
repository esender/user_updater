require 'spec_helper'
require_relative '../../../../apps/api/views/users/count'

describe Api::Views::Users::Count do
  let(:exposures) { Hash[count_hash: { count: 1 }] }
  let(:view)      { Api::Views::Users::Count.new(_, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.count_hash.must_equal exposures.fetch(:count_hash)
  end

  it 'render to hash' do
    rendered.must_equal exposures[:count_hash].to_json
  end
end
