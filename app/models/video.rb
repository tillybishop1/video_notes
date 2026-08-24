class Video < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy
  
  validates :title, presence: true
  validates :mux_playback_id, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
end
