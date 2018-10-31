``` javascript
import {
  html,
  render,
} from "https://unpkg.com/lit-html?module";

class AppContainerComponent extends HTMLElement {
  static get observedAttributes() {
    return [
    ];
  }

  get template() {
    return html`
      <p>hello</p>
    `;
  }

  constructor() {
    super();

    this.attachShadow({
      mode: "open",
    });

    render(this.template, this.shadowRoot);
  }

  connectedCallback() {
  }

  disconnectedCallback() {
  }

  attributeChangedCallback() {
    render(this.template, this.shadowRoot);
  }
}

customElements.define("app-container", AppContainerComponent);
```
