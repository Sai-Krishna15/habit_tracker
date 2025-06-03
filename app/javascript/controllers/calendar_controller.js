import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  previousMonth(event) {
    event.preventDefault();
    const month = event.currentTarget.dataset.month;
    const year = event.currentTarget.dataset.year;
    const habitId = event.currentTarget.dataset.habitId;
    this.updateCalendar(habitId, month, year);
  }

  nextMonth(event) {
    event.preventDefault();
    const month = event.currentTarget.dataset.month;
    const year = event.currentTarget.dataset.year;
    const habitId = event.currentTarget.dataset.habitId;
    this.updateCalendar(habitId, month, year);
  }

  updateCalendar(habitId, month, year) {
    const url = `/habits/${habitId}?month=${month}&year=${year}`;
    fetch(url, {
      headers: {
        Accept: "text/html",
        "X-Requested-With": "XMLHttpRequest",
      },
    })
      .then((response) => response.text())
      .then((html) => {
        const habitElement = document.getElementById(`habit_${habitId}`);
        if (habitElement) {
          habitElement.outerHTML = html;
        }
      });
  }
}
