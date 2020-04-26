class Bond < Sequel::Model
end

# Table: bonds
# Columns:
#  id               | integer      | PRIMARY KEY AUTOINCREMENT
#  valid_from       | timestamp    | NOT NULL
#  valid_to         | timestamp    | NOT NULL
#  seen_at          | timestamp    |
#  how_do_you_feel  | integer      |
#  feedback_message | text         |
#  url_stub_id      | varchar(255) | NOT NULL
#  f_schedule_id    | integer      |
#  f_ward_id        | integer      |
# Indexes:
#  sqlite_autoindex_bonds_1 | UNIQUE (url_stub_id)
# Foreign key constraints:
#  (f_schedule_id) REFERENCES schedules
#  (f_ward_id) REFERENCES wards
