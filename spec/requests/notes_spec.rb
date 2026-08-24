require "rails_helper"

RSpec.describe "Notes" do
  let(:user) { User.create!(email: "user@example.com", password: "password123") }
  let(:video) { Video.create!(title: "Intro to Pottery", mux_playback_id: "abc123") }

  before { sign_in user }

  describe "POST /videos/:video_id/notes" do
    it "creates a note and streams it into the notes list" do
      expect {
        post video_notes_path(video),
             params: { note: { content: "Great tip here", timestamp: 12 } },
             as: :turbo_stream
      }.to change(Note, :count).by(1)

      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(response.body).to include('turbo-stream action="append" target="notes"')
    end

    it "does not create a note without content" do
      expect {
        post video_notes_path(video),
             params: { note: { content: "", timestamp: 12 } },
             as: :turbo_stream
      }.not_to change(Note, :count)
    end
  end

  describe "DELETE /videos/:video_id/notes/:id" do
    it "deletes the note and renders successfully" do
      note = video.notes.create!(content: "Great tip here", timestamp: 12, user: user)

      expect {
        delete video_note_path(video, note), as: :turbo_stream
      }.to change(Note, :count).by(-1)

      expect(response).to have_http_status(:success)
    end

    it "does not allow deleting another user's note" do
      other_user = User.create!(email: "other@example.com", password: "password123")
      note = video.notes.create!(content: "Great tip here", timestamp: 12, user: other_user)

      expect {
        delete video_note_path(video, note)
      }.not_to change(Note, :count)
    end
  end
end
