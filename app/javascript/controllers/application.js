import { application } from "controllers/application"

// Importe os controllers que você está usando
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)