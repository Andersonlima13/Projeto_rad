### hello_controller

File: `app/javascript/controllers/hello_controller.js`

```javascript
export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
```

Usage:
```html
<div data-controller="hello"></div>
```
On connect, the div's text content becomes "Hello World!".