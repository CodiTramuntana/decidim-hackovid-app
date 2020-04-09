class AddFieldsToSolutions < ActiveRecord::Migration[5.2]
  def change
    change_table :solutions do |t|
      t.text :explanation
      t.string :source_link
      t.attachment :file
    end
  end
end
