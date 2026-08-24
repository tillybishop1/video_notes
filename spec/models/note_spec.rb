require "rails_helper"

RSpec.describe Note do
  let(:video) { Video.create!(title: "Intro to Pottery", mux_playback_id: "abc123") }
  let(:user) { User.create!(email: "user@example.com", password: "password123") }

  describe "#formatted_timestamp" do
    it "formats seconds as HH:MM:SS" do
      note = Note.new(content: "Great tip here", timestamp: 3725, video: video, user: user)
      expect(note.formatted_timestamp).to eq("01:02:05")
    end
  end
end
