### Visão geral do Stimulus

O Stimulus é inicializado via Importmap em `app/javascript/application.js`:

```javascript
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
```

Os controllers são registrados por `app/javascript/controllers/application.js` e `app/javascript/controllers/index.js`:

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

Padrão de uso:
- Anexe um controller a um elemento com `data-controller`.
- Faça o binding de ações com `data-action`.
- Defina targets com `static targets = ["name"]` e acesse via `this.nameTarget`.

Exemplo para adicionar um novo controller:
```bash
bin/rails generate stimulus counter
```
Depois, use-o:
```html
<div data-controller="counter">
  <button data-action="click->counter#increment">+</button>
  <span data-counter-target="output">0</span>
</div>
```
