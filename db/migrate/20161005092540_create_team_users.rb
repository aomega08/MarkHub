class CreateTeamUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_users do |t|
      t.integer :team_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_foreign_key :team_users, :teams
    add_foreign_key :team_users, :users
  end
end
