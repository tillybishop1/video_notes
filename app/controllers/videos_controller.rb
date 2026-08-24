class VideosController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @videos = Video.recent
  end

  def show
    @video = Video.find(params[:id])
    @notes = @video.notes.where(user: current_user)
    @note = @video.notes.build
  end
end
