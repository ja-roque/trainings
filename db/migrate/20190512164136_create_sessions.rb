class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.integer :number
      t.references :training, foreign_key: true

      t.timestamps
    end
  end
end
