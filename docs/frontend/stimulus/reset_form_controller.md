### reset_form_controller

File: `app/javascript/controllers/reset_form_controller.js`

```javascript
export default class extends Controller {
  reset() {
    this.element.reset()
  }
}
```

Usage options:
- Reset a form on a button click:
```html
<form data-controller="reset-form">
  <!-- fields -->
  <button type="button" data-action="click->reset-form#reset">Clear</button>
</form>
```
- Reset after a Turbo form submission succeeds:
```html
<form data-controller="reset-form" data-action="turbo:submit-end->reset-form#reset">
  <!-- fields -->
</form>
```