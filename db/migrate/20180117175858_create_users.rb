class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :age
      t.float :height
      t.float :weight
      t.string :color

      t.timestamps
    end
  end
end
