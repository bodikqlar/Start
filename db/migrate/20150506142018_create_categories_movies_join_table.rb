class CreateCategoriesMoviesJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_movies, id: false do |t|
      t.belongs_to :category
      t.belongs_to :movie
    end
    add_index :categories_movies, [:category_id, :movie_id], unique: true
  end
end
