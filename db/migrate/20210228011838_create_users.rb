class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, default: false
      t.string :email, default: false
      t.string :token
      t.string :password_digest, default: false

      t.timestamps
    end
    add_index :users, :token
  end
end
