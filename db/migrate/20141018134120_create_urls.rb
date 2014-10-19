class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text       :url
      t.integer    :number_of_visits, default: 0
      t.references :user

      t.timestamps
    end

    add_index :urls, :user_id
    add_index :urls, :url, unique: true
  end
end
