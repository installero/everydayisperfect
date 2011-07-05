class CreateRepetitions < ActiveRecord::Migration
  def self.up
    create_table :repetitions do |t|
      t.integer :day
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :repetitions
  end
end
