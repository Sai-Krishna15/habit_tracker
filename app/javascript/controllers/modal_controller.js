import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Modal controller connected");
  }

  close(event) {
    event.preventDefault();
    const modalFrame = document.querySelector(
      '[data-turbo-frame="delete_modal"]'
    );
    if (modalFrame) {
      modalFrame.innerHTML = "";
    }
  }
}
