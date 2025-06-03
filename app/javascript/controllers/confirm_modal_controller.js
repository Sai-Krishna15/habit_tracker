import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "confirmButton", "cancelButton"];
  static values = {
    deleteUrl: String,
  };

  connect() {
    console.log("Confirm modal controller connected");
    this.modalTarget.classList.add("hidden");
  }

  show(event) {
    console.log("Show modal triggered");
    event.preventDefault();
    event.stopPropagation();

    const deleteUrl = event.currentTarget.dataset.confirmModalDeleteUrlValue;
    console.log("Delete URL:", deleteUrl);
    this.deleteUrlValue = deleteUrl;

    this.modalTarget.classList.remove("hidden");
    console.log("Modal should be visible now");
  }

  hide() {
    console.log("Hide modal triggered");
    this.modalTarget.classList.add("hidden");
  }

  confirm() {
    console.log("Confirm delete triggered");
    const form = document.createElement("form");
    form.method = "POST";
    form.action = this.deleteUrlValue;

    const methodInput = document.createElement("input");
    methodInput.type = "hidden";
    methodInput.name = "_method";
    methodInput.value = "DELETE";

    const csrfInput = document.createElement("input");
    csrfInput.type = "hidden";
    csrfInput.name = "authenticity_token";
    csrfInput.value = document.querySelector('meta[name="csrf-token"]').content;

    form.appendChild(methodInput);
    form.appendChild(csrfInput);
    document.body.appendChild(form);
    form.submit();
  }
}
