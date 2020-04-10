class AddRepresentativeFieldsToSolutions < ActiveRecord::Migration[5.2]
  def change
    change_table :solutions do |t|
      t.string :representative_email, null: false
      t.string :representative_first_name, null: false
      t.string :representative_last_name, null: false
      t.string :representative_phone_num
    end
  end
end
