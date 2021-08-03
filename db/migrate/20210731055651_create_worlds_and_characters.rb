class CreateWorldsAndCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :worlds do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :name,  null: false, unique: true
      t.string :description

      t.timestamps null: false
    end

    create_table :characters do |t|
      t.references :world, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true, null: false
      t.string :first_name,  null: false
      t.string :last_name
      t.string :title
      t.string :description
      t.string :filename, unique: true

      t.timestamps null: false
    end

    create_table :relationship_types do |t|
      t.string :name, null: false, unique: true
      t.string :description
      t.string :color

      t.timestamps null: false
    end

    create_table :relationships do |t|
      t.references :character, index: true, foreign_key: true, null: false
      t.references :relationship_with, index: true, foreign_key: {to_table: :characters}, null: false
      t.references :relationship_type, index: true, foreign_key: true
      t.references :world, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true, null: false
      t.string :color
      t.string :name
      t.string :description
      t.references :relationship_type_forward, index: true, foreign_key: {to_table: :relationship_types}
      t.string :name_forward
      t.string :description_forward
      t.references :relationship_type_backward, index: true, foreign_key: {to_table: :relationship_types}
      t.string :name_backward
      t.string :description_backward

      t.timestamps null: false
    end
    add_index :relationships, 'greatest(character_id,relationship_with_id), least(character_id,relationship_with_id)',
      name: 'index_relationships_unique', unique: true
  end
end
