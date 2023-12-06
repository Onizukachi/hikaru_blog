import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-message"
export default class extends Controller {
  static targets = ['flash']

  connect() {
    setTimeout(() => {
      this.flashTarget.remove();
    }, 5000) // Remove flash message after 5 seconds
  }

  close() {
    this.flashTarget.remove()
  }
}
