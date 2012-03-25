class CreateComplaints < ActiveRecord::Migration
  def self.up
    create_table :complaints do |t|
      t.string :bin
      t.string :latest
      t.string :date

      t.timestamps
    end
  end

  def self.down
    drop_table :complaints
  end
end
