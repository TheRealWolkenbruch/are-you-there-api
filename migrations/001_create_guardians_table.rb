Sequel.migration do
  change do
    create_table(:guardians) do
      primary_key :id
      String :name, null: false
      String :email, null: false
      String :password, null: false
      String :password_confirmation, null: false
    end
  end
end
