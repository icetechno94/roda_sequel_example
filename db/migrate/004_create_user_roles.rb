# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:user_roles) do
      primary_key :id

      foreign_key(:user_id, :users)
      foreign_key(:role_id, :roles)
    end
  end
end
