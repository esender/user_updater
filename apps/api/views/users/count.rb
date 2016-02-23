module Api::Views::Users
  class Count
    include Api::View

    def render
      raw count_hash.to_json
    end
  end
end
