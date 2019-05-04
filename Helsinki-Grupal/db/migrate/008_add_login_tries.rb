migration 8, :add_login_tries do
  up do
    modify_table :users do
      add_column :login_tries, DataMapper::Property::Integer, :default => 0
      add_column :lock_deadline, DataMapper::Property::DateTime, :default => DateTime.parse('1970-01-01 00:00:00')
    end
  end

  down do
    modify_table :users do
      drop_column :login_tries
      drop_column :lock_deadline
    end
  end
end