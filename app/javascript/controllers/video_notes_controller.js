import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video-notes"
export default class extends Controller {
  static targets = ["player", "timestampInput", "currentTime"]
  
  connect() {
    console.log("Video notes controller connected")
    
    if (this.hasPlayerTarget) {
      this.player = this.playerTarget
      
      this.player.addEventListener('timeupdate', () => {
        if (this.hasCurrentTimeTarget) {
          this.currentTimeTarget.textContent = this.formatTime(this.player.currentTime)
        }
      })
      
      console.log("Mux player initialized")
    }
  }
  
  captureTimestamp(event) {
    if (this.hasPlayerTarget && this.hasTimestampInputTarget) {
      const currentTime = Math.floor(this.player.currentTime)
      this.timestampInputTarget.value = currentTime
      console.log("Captured timestamp:", currentTime)
    }
  }
  
  seekTo(event) {
    const time = parseInt(event.params.time)
    
    if (this.hasPlayerTarget && !isNaN(time)) {
      this.player.currentTime = time
      this.player.play()
      console.log("Seeking to:", time)
      
      window.scrollTo({ top: 0, behavior: 'smooth' })
    }
  }
  
  formatTime(seconds) {
    if (isNaN(seconds)) return "00:00:00"
    
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    const secs = Math.floor(seconds % 60)
    
    return [hours, minutes, secs]
      .map(v => v < 10 ? "0" + v : v)
      .join(":")
  }
}
