migration 9, :add_offer_status do
  up do
    modify_table :job_offers do
      add_column :status, DataMapper::Property::Integer, :default => 0
    end
  end

  down do
    modify_table :job_offers do
      drop_column :status
    end
  end
end