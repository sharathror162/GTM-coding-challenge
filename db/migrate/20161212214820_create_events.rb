class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :hostname
      t.string :org
      t.datetime :created

      t.timestamps null: false
    end
  end
end
