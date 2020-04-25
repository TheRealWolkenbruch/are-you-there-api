# Schedule entity
Sequel.migration do
  change do
    create_table(:schedules) do
      primary_key :id
      String :title, null: false
      String :headline, null: false
      String :description, null: false, text: true
      DateTime :starting_from, null: false
      Integer :interval_hours , null: false
      foreign_key :f_ward_id , :wards
    end
  end
end
