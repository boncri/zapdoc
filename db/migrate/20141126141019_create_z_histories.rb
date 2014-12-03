class CreateZHistories < ActiveRecord::Migration
  #@jtodoMED use change and remove down
  def up
    create_table :z_histories do |t|
      t.datetime :history_date
      t.uuid :z_item_id
      t.integer :revision

      t.timestamps
    end
  end

  def down
    drop_table :z_histories
  end
end
