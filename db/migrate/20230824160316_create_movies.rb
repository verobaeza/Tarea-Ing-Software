class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :sinopsis
      t.integer :duration
      t.date :premiere
      t.belongs_to :director

      t.timestamps
    end
  end
end
