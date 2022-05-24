# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:roles) do
      primary_key :id

      column :name, String, null: false, unique: true
      column :key, String, null: false, unique: true
    end
  end
end
