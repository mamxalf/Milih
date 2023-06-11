import { Controller } from '@hotwired/stimulus';
import consumer from '../channels/consumer';

// Connects to data-controller="pollings"
export default class extends Controller {
  connect() {
    this.subscription = consumer.subscriptions.create(
      {
        channel: 'PollingsChannel',
        polling_id: this.element.dataset.pollingId,
      },
      {
        connected: this._connected.bind(this),
        received: this._received.bind(this),
      },
    );
  }

  _connected() {}

  _received(data) {
    if (data.total !== 0) {
      data.data.forEach((d) => {
        const percentage = `${Math.floor((d.amount * 100) / data.total)}%`;
        const elementDiv = document.getElementById(d.polling_answer_id);
        elementDiv.textContent = percentage;
        elementDiv.style.width = percentage;
      });
    }
  }

  disconnect() {
    this.subscription.unsubscribe();
  }
}
