import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categorySelect"]

  updateCategories(event) {
    const transactionType = event.target.value
    fetch(`/categories/options?transaction_type=${transactionType}`, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}