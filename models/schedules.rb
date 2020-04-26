class Schedule < Sequel::Model
end

# Table: schedules
# Columns:
#  id             | integer      | PRIMARY KEY AUTOINCREMENT
#  title          | varchar(255) | NOT NULL
#  headline       | varchar(255) | NOT NULL
#  description    | text         | NOT NULL
#  starting_from  | timestamp    | NOT NULL
#  interval_hours | integer      | NOT NULL
#  f_ward_id      | integer      |
# Foreign key constraints:
#  (f_ward_id) REFERENCES wards
