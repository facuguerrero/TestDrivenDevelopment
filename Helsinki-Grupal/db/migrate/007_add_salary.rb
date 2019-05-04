migration 7, :add_salary do
  up do
    modify_table :job_offers do
      add_column :salary, Integer
      add_column :experience, Integer
    end
  end

  down do
    modify_table :job_offers do
      drop_column :salary
    end
  end
end
