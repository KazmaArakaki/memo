``` javascript
const openTab = async (url) => {
  return new Promise((resolve) => {
    const tab = window.open(url, "_blank");
    tab.onload = () => {
      console.log(`opend: ${url}`);
      resolve(tab);
    };
  });
};

(async () => {
  for (const item of document.querySelectorAll(".listResult .link")) {
    const tab = await openTab(item.href);
    tab.close();
  }
})();
```
