class DataSequence < ApplicationRecord
  belongs_to :graph
  validates :graph, presence: true
  validates :data, presence: true

  after_commit { DataSequenceUpdateJob.perform_later(self) }
end
