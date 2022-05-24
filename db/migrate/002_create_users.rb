# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id

      column :uuid, :uuid, index: true, default: Sequel.function(:uuid_generate_v4)
      column :email, String, null: false
      column :blocked, FalseClass, default: false
    end
  end
end
