class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :article, null: false, foreign_key: true
      t.references :reply_to, null: true, foreign_key: { to_table: :comments }, default: nil
      t.text :text, null: false

      t.timestamps
    end
  end
end
