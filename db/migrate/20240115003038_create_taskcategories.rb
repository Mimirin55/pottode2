class CreateTaskcategories < ActiveRecord::Migration[7.0]
  def change
    create_table :taskcategories do |t|
      t.references :task, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
