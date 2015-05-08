class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :rating
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
