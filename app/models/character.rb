class Character < ApplicationRecord
  belongs_to :user
  belongs_to :world
  has_many :relationships
  has_many :related_characters, through: :relationships
  has_many :inverse_relationships, foreign_key: :relationship_with_id, class_name: "Relationships"
  has_many :inverse_related_characters, through: :inverse_relationships, foreign_key: :character_id
end