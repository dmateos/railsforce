class Graph < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :name, presence: true
  validates :g_type, presence: true
  validates_uniqueness_of :tag
end
