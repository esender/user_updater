require 'spec_helper'
require_relative '../../../../apps/api/controllers/users/count'

describe Api::Controllers::Users::Count do
  let(:action) { Api::Controllers::Users::Count.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
