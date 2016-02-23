Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :shard_id, Integer
    end
  end
end
