import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toast"];

  connect() {
    this.toastTargets.forEach((toast) => {
      toast.classList.add("animate-slide-in");
      setTimeout(() => {
        toast.classList.remove("animate-slide-in");
        toast.classList.add("animate-slide-out");
      }, 5000);
    });
  }

  remove(event) {
    event.target.remove();
  }
}
