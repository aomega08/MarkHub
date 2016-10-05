class CreateSocialEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :social_entities do |t|
      t.integer :team_id, null: false
      t.string :network, null: false
      t.string :kind
      t.string :display_name, null: false
      t.string :network_id, null: false
      t.text :credentials

      t.timestamps
    end

    add_foreign_key :social_entities, :teams
    add_index :social_entities, [:team_id, :network, :kind, :network_id], unique: true, name: 'unique_entities'
  end
end
