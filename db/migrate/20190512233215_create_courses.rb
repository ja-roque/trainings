class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.references :user, foreign_key: true
      t.references :session, foreign_key: true
      t.integer :score
      t.text :comments
      t.integer :progress

      t.timestamps
    end
  end
end
