class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.references :user,    null: false
      t.string :name,        null: false
      t.string :storage_key, null: false

      t.timestamps

    end
    add_index :sources, :user_id
    add_index :sources, %i[user_id name], unique: true
    add_index :sources, :storage_key,     unique: true
  end
end
