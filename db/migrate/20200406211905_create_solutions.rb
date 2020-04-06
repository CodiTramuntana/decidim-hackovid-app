class CreateSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :solutions do |t|
      t.string :title
      t.text :description
      t.text :youtube_link
      t.string :github_link
      t.references :decidim_category, foreign_key: true
      t.string :web_url
      t.string :android_mkt_url
      t.string :ios_mkt_url
      t.references :ods, foreign_key: true
      t.datetime :published_at 

      t.timestamps
    end
    add_index :solutions, :title
  end
end
