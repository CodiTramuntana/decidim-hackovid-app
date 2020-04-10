class AddFirebaseFieldsToSolutions < ActiveRecord::Migration[5.2]
  def change
    change_table :solutions do |t|
      t.boolean :firebase_shared, null: false, default: false
      t.string :firebase_name
    end
    remove_column :solutions, :source_link, :string
  end
end
