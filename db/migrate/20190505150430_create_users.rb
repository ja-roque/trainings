class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :type
      t.string :firstname
      t.string :lastname
      t.integer :exp
      t.string :department
      t.string :area
      t.string :role

      t.timestamps
    end
  end
end
