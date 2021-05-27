class CreateWorld < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references  :product,  index: true
      t.string :body
      t.float :rating

      t.timestamps
    end

    create_table :products do |t|
      t.references  :shop,  index: true
      t.string :title

      t.timestamps
    end

    create_table :shops do |t|
      t.string :name

      t.timestamps
    end
  end
end
