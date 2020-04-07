class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.text :youtube_link, null: false
      t.string :github_link, null: false
      t.string :web_url
      t.string :android_mkt_url
      t.string :ios_mkt_url
      t.references :sd_goal, foreign_key: true
      t.string :team_name, null: false

      t.references :decidim_user, index: true

      t.timestamps
    end
    add_index :solutions, :title
  end
end
