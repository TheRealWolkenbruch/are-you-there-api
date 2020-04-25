# Bond entity
Sequel.migration do
  change do
    create_table(:bonds) do
      primary_key :id
      DateTime :valid_from, null: false
      DateTime :valid_to, null: false
      DateTime :seen_at, null: true
      Integer :how_do_you_feel, null: true
      String :feedback_message, null: true, text: true
      String :url_stub_id , null: false, unique: true
      foreign_key :f_schedule_id , :schedules
    end
  end
end
