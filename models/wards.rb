class Ward < Sequel::Model
end

# Table: wards
# Columns:
#  id                  | integer      | PRIMARY KEY AUTOINCREMENT
#  human_readable_name | varchar(255) | NOT NULL
#  contactdata         | text         | NOT NULL
#  email               | varchar(255) | NOT NULL
#  password            | varchar(255) | NOT NULL
#  f_guardian_id       | integer      |
#  deleted             | integer      | DEFAULT 0
# Indexes:
#  sqlite_autoindex_wards_1 | UNIQUE (email)
# Foreign key constraints:
#  (f_guardian_id) REFERENCES guardians
