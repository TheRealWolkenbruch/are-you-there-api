# frozen_string_literal: true

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
# Foreign key constraints:
#  (f_guardian_id) REFERENCES guardians
