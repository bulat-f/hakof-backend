class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :slug
      t.string :cover
      t.string :description
      t.text :body
      t.string :lang, null: false
      t.integer :author_id, null: false
      t.string :link

      t.datetime :published_at

      t.boolean :selected, null: false, default: false
      t.boolean :featured, null: false, default: false

      t.integer :views_count, null: false, default: 0
      t.integer :views_till_end_count, null: false, default: 0
      t.integer :sum_view_time_sec, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.string :tags, array: true, null: false, default: []

      t.timestamps
    end

    add_index :articles, :author_id
    add_index :articles, :slug, unique: true
    add_index :articles, :lang
    add_index :articles, :selected
    add_index :articles, :featured
  end
end
