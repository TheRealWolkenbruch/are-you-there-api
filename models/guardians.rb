# frozen_string_literal: true

class Guardian < Sequel::Model
end

# Table: guardians
# Columns:
#  id       | integer      | PRIMARY KEY AUTOINCREMENT
#  name     | varchar(255) | NOT NULL
#  email    | varchar(255) | NOT NULL
#  password | varchar(255) | NOT NULL
