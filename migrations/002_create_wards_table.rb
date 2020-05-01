# frozen_string_literal: true

# Ward entity
Sequel.migration do
  change do
    create_table(:wards) do
      primary_key :id
      String :human_readable_name, null: false
      String :contactdata, null: false, text: true
      String :email, null: false, unique: true
      String :password, null: false
      foreign_key :f_guardian_id, :guardians
    end
  end
end
