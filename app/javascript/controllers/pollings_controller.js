import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

// Connects to data-controller="pollings"
export default class extends Controller {
  connect() {
    this.subscription = consumer.subscriptions.create(
        {
          channel: "PollingsChannel",
          polling_id: this.element.dataset.pollingId
        },
        {
          connected: this._connected.bind(this),
          disconnected: this._disconnected.bind(this),
          received: this._received.bind(this),
        }
    );
  }

  _connected() {
    console.log('POLLING', 'CONNECTED!');
  }

  _disconnected() {}

  _received(data) {
    // const element = this.statusTarget
    // element.innerHTML = data
    console.log('NOTIF', data)
  }

  disconnect() {
    this.subscription.unsubscribe();
  }
}
