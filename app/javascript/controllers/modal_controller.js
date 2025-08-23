// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  static targets = ["modal"]

  open(e) {
    e.preventDefault()
    
    fetch(this.element.href, {
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => {
      document.body.insertAdjacentHTML('beforeend', html)
      const modal = new bootstrap.Modal(document.getElementById('accountModal'))
      modal.show()
      
      document.getElementById('accountModal').addEventListener('hidden.bs.modal', () => {
        document.getElementById('accountModal').remove()
      })
    })
  }
}