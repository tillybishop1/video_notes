class NotesController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    @note = @video.notes.new(note_params)

    if @note.save
      redirect_to @video, notice: "Note created successfully."
    else
      redirect_to @video, alert: "Error creating note."
    end
  end

  def destroy
    @video = Video.find(params[:video_id])
    @note = @video.notes.find(params[:id])
    @note.destroy

    redirect_to @video, notice: "Note deleted successfully."
  end

  private

  def note_params
    params.require(:note).permit(:content, :timestamp, :user_id, :video_id, :created_at, :updated_at)
  end
end
