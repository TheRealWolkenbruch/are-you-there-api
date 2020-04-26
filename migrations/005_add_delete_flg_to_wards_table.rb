Sequel.migration do
  up do
    add_column :wards, :deleted, Integer, default: false
    from(:wards).update(deleted: false)
  end

  down do
    drop_column :wards, :deleted
  end
end
