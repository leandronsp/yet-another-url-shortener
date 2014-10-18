class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text    :url
      t.integer :number_of_visits, default: 0

      t.timestamps
    end

    add_index :urls, :url
  end
end
