// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import ModalController from "./modal_controller"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
application.register("modal", ModalController)
