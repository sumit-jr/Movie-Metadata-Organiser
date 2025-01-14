class CreateEpisodes < ActiveRecord::Migration[7.2]
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :description
      t.boolean :paid
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
