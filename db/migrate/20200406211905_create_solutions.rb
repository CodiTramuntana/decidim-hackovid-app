class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.string :title
      t.text :description
      t.text :youtube_link
      t.string :github_link
      t.string :web_url
      t.string :android_mkt_url
      t.string :ios_mkt_url
      t.references :sd_goal, foreign_key: true
      t.string :team_name
      t.string :responsible_info
      t.datetime :published_at 

      t.timestamps
    end
    add_index :solutions, :title
  end
end
