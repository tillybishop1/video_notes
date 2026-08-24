class Note < ApplicationRecord
  belongs_to :video
  belongs_to :user
  
  validates :content, presence: true
  validates :timestamp, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  def formatted_timestamp
    Time.at(timestamp).utc.strftime("%H:%M:%S")
  end
end
