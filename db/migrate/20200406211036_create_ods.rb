class CreateOds < ActiveRecord::Migration[5.2]
  def change
    create_table :ods do |t|
      t.jsonb :name

      t.timestamps
    end
  end
end
