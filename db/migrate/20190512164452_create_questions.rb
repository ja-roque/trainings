class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :text
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
