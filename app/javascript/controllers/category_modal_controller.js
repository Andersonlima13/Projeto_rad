import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeModal(event) {
    if (event.type === "turbo:submit-end" && event.detail.success) {
      const modal = bootstrap.Modal.getInstance(this.element)
      modal.hide()
    }
  }
}
