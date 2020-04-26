# frozen_string_literal: true

# Guardian entity
Sequel.migration do
  change do
    create_table(:guardians) do
      primary_key :id
      String :name, null: false
      String :email, null: false, unique: true
      String :password, null: false
    end
  end
end
