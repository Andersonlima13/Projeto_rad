### hello_controller

Arquivo: `app/javascript/controllers/hello_controller.js`

```javascript
export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
```

Uso:
```html
<div data-controller="hello"></div>
```
Ao conectar, o texto do elemento se torna "Hello World!".