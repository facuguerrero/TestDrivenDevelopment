migration 5, :add_candidates_number_to_job_offers do
  up do
    modify_table :job_offers do
      add_column :is_active, TrueClass
      add_column :candidates_number, Integer, :default => 0
    end
  end

  down do
    modify_table :job_offers do
      drop_column :is_active
      drop_column :candidates_number
    end
  end
end
