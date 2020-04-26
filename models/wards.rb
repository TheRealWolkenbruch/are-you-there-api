# frozen_string_literal: true

require_relative 'schedules'
require_relative 'bonds'
class Ward < Sequel::Model
  one_to_many :schedules, key: :f_ward_id
  plugin :many_through_many
  many_through_many :bonds,
                    through: [
                      %i[schedules id f_ward_id],
                      %i[bonds id f_schedule_id]
                    ]
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
