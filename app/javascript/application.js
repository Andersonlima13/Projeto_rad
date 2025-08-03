// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap" // Importa o Bootstrap para uso no projeto

// Importe os componentes JS do Bootstrap que você precisa
import { Tooltip, Popover } from 'bootstrap';

// Inicialize os componentes
document.addEventListener('DOMContentLoaded', () => {
  [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    .forEach(tooltipNode => new Tooltip(tooltipNode));
  
  [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    .forEach(popoverNode => new Popover(popoverNode));
});


