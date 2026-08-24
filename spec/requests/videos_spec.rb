require "rails_helper"

RSpec.describe "Videos" do
  let(:user) { User.create!(email: "user@example.com", password: "password123") }
  let(:video) { Video.create!(title: "Intro to Pottery", mux_playback_id: "abc123") }

  describe "GET /videos" do
    it "redirects to sign in when not authenticated" do
      get videos_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "succeeds when authenticated" do
      sign_in user
      video # ensure the video exists before the request
      get videos_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(video.title)
    end
  end

  describe "GET /videos/:id" do
    it "succeeds when authenticated" do
      sign_in user
      get video_path(video)
      expect(response).to have_http_status(:success)
    end
  end
end
