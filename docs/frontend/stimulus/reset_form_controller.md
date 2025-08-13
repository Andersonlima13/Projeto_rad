### reset_form_controller

Arquivo: `app/javascript/controllers/reset_form_controller.js`

```javascript
export default class extends Controller {
  reset() {
    this.element.reset()
  }
}
```

Opções de uso:
- Resetar um formulário ao clicar no botão:
```html
<form data-controller="reset-form">
  <!-- campos -->
  <button type="button" data-action="click->reset-form#reset">Limpar</button>
</form>
```
- Resetar após o envio do formulário Turbo ser concluído com sucesso:
```html
<form data-controller="reset-form" data-action="turbo:submit-end->reset-form#reset">
  <!-- campos -->
</form>
```