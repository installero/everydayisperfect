class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.text :description
      t.datetime :start
      t.string :routine

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
