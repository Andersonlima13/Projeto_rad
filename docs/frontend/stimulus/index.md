### Stimulus overview

Stimulus is initialized via Importmap in `app/javascript/application.js`:

```javascript
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
```

Controllers are registered by `app/javascript/controllers/application.js` and `app/javascript/controllers/index.js`:

```javascript
// app/javascript/controllers/application.js
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
```

```javascript
// app/javascript/controllers/index.js
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
```

Usage pattern:
- Attach a controller to an element with `data-controller`.
- Bind actions with `data-action`.
- Define targets with `static targets = ["name"]` and reference via `this.nameTarget`.

Add a new controller example:
```bash
bin/rails generate stimulus counter
```
Then use it:
```html
<div data-controller="counter">
  <button data-action="click->counter#increment">+</button>
  <span data-counter-target="output">0</span>
</div>
```