class CreateEpisodeUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :episode_users do |t|
      t.references :episode, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
