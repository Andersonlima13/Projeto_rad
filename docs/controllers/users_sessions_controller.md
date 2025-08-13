### Users::SessionsController

Overrides Devise sessions create to customize flash and redirection.

#### Actions
- `create`
  - Authenticates with Warden (`warden.authenticate!`) and signs the user in
  - On success: sets flash `:notice` and redirects to `after_sign_in_path_for(resource)` (dashboard)
  - On error: rescues, sets `flash.now[:alert] = "Falha no login: ..."` and renders `:new`

#### Routes
Handled by Devise under `/users`:
- `GET /users/sign_in`
- `POST /users/sign_in`
- `DELETE /users/sign_out`

#### Example
```bash
curl -i -X POST -H "Content-Type: application/x-www-form-urlencoded" \
  -c cookies.txt -d "user[email]=you@example.com&user[password]=secret" \
  http://localhost:3000/users/sign_in
```