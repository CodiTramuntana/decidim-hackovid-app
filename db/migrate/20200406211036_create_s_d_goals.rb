class CreateSDGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :sd_goals do |t|
      t.jsonb :name

      t.timestamps
    end
  end
end
