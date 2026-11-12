// Documentation: https://github.com/johnste/finicky
const browsers = {
  "org.mozilla.firefox": "Firefox",
  "com.google.Chrome": "Google Chrome",
};

export default {
  // Finicky can't see which browser was used last, so approximate it:
  // the browser the link came from, else the only running browser, else Chrome
  defaultBrowser: (url, { opener }) => {
    if (opener && browsers[opener.bundleId]) {
      return browsers[opener.bundleId];
    }
    const running = Object.keys(browsers).filter((id) => finicky.isAppRunning(id));
    if (running.length === 1) {
      return browsers[running[0]];
    }
    return "Google Chrome";
  },
  handlers: [
    {
      // Personal sites
      match: [
        "github.com/aukoyy",
        "github.com/aukoyy/*",
        "x.com/*",
        "*.x.com/*",
        "youtube.com/*",
        "*.youtube.com/*",
        "youtu.be/*",
        "wolt.com/*",
        "*.wolt.com/*",
        "rylon.dev/*",
        "bulder.no/*",
        "*.bulder.no/*",
        "ask.webtopsolutions.com/*",
        "sunsama.com/*",
        "*.sunsama.com/*",
      ],
      browser: "Firefox",
    },
    {
      // Work sites (all GitHub except github.com/aukoyy, matched above)
      match: [
        "github.com",
        "github.com/*",
        "aws.amazon.com/*",
        "*.aws.amazon.com/*",
        "*.awsapps.com/*",
        "*.amazonaws.com/*",
        "shortcut.com/*",
        "*.shortcut.com/*",
        "flowcase.com/*",
        "*.flowcase.com/*",
        "tripletex.no/*",
        "*.tripletex.no/*",
      ],
      browser: "Google Chrome",
    },
  ],
};
