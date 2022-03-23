import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "id",
    "source",
    "response",
    "difficulty",
    "form",
    "new_rebus",
  ];

  async guess() {
    const token = this.getCookie("auth_token");
    const id = this.idTarget.attributes.value.value;
    const guess = this.sourceTarget.value;
    const rep = await fetch(`/rebus/${id}/guess`, {
      method: "POST",
      credentials: "same-origin",
      headers: {
        Authorization: `Bearer ${token}`,
        accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ guess }),
    });
    if (rep.status >= 400) {
      this.responseTarget.value = "An error occur with network";
    } else {
      const rep_j = await rep.json();
      this.responseTarget.innerText = rep_j["message"];
      this.difficultyTarget.innerText = `Rebus d'une difficulte de ${rep_j["difficulty"]}`;
      if (rep_j["correct"]) {
        console.log("coorect");
        this.new_rebusTarget.hidden = false;
        this.formTarget.style.display = "none";
      }
    }
  }

  async pass() {
    const token = this.getCookie("auth_token");
    const id = this.idTarget.attributes.value.value;
    console.log(id);
    const rep = await fetch(`/rebus/${id}/pass`, {
      method: "POST",
      credentials: "same-origin",
      headers: {
        Authorization: `Bearer ${token}`,
        accept: "application/json",
        "Content-Type": "application/json",
      },
    });
    if (rep.status >= 400) {
      this.responseTarget.value = "An error occur with network";
    } else {
      this.responseTarget.innerText = "You pass the rebus";
      this.find_pass();
    }
  }

  find_pass() {
    location.reload();
  }

  getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(";").shift();
  }
}
