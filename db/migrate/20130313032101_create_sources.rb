class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.references :user, null: false
      t.string :klass,    null: false
      t.string :name,     null: false
      t.string :param

      t.timestamps

    end
    add_index :sources, %i[klass name], unique: true
  end
end
