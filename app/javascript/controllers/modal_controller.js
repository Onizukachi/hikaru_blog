import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modalFullWindow", "modal"]

  connect() {
  }

  hideModal() {
    // Remove src reference from parent frame element
    // Without this, turbo won't re-open the modal on subsequent click
    this.element.parentElement.removeAttribute("src")
    this.modalFullWindowTarget.remove();
  }

  // hide modal when clicking ESC
  // action: "keyup@window->turbo-modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->turbo-modal#closeBackground"
  closeBackground(e) {
    if (e && this.modalTarget.contains(e.target)) {
      return
    }
    
    this.hideModal()
  }
}
