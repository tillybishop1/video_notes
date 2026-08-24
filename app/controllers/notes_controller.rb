class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :set_video
  before_action :set_note, only: [:destroy]
  before_action :authorize_note, only: [:destroy]
  
  def create
    @note = @video.notes.build(note_params)
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("notes", partial: "notes/note", locals: { note: @note }),
            turbo_stream.replace("new_note", partial: "notes/form", locals: { video: @video, note: @video.notes.build })
          ]
        end
        format.html { redirect_to @video, notice: "Note created successfully." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_note", partial: "notes/form", locals: { video: @video, note: @note })
        end
        format.html { redirect_to @video, alert: "Error creating note: #{@note.errors.full_messages.join(', ')}" }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@note)) }
      format.html { redirect_to @video, notice: "Note deleted successfully." }
    end
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
  end
  
  def set_note
    @note = @video.notes.find(params[:id])
  end
  
  def authorize_note
    redirect_to @video, alert: "Unauthorized" unless @note.user == current_user
  end

  def note_params
    params.require(:note).permit(:content, :timestamp)
  end
end
