// app/javascript/application.js
import "@hotwired/turbo-rails"
import { Modal, Toast } from "bootstrap" // Importe apenas o necessário
import "./controllers"

// Inicialização global de componentes Bootstrap
document.addEventListener("turbo:load", () => {
  // Inicializa modais
  document.querySelectorAll('.modal').forEach(modalEl => {
    const modal = new Modal(modalEl)
    modal.show()
    
    modalEl.addEventListener('hidden.bs.modal', () => {
      modalEl.remove()
      document.querySelector('.modal-backdrop')?.remove()
    })
  })
  
  // Outros componentes podem ser adicionados aqui
})