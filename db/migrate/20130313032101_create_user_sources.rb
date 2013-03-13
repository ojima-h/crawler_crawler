class CreateUserSources < ActiveRecord::Migration
  def change
    create_table :user_sources do |t|
      t.references :user,     null: false
      t.string :source_class, null: false
      t.string :name,         null: false
      t.string :param

      t.timestamps

    end
    add_index :user_sources, %i[source_class name], unique: true
  end
end
