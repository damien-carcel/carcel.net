/* eslint-disable @typescript-eslint/no-var-requires */

const PrerenderSpaPlugin = require('prerender-spa-plugin');
const path = require('path');

module.exports = {
  configureWebpack: () => {
    if (process.env.NODE_ENV !== 'production') return;

    return {
      plugins: [new PrerenderSpaPlugin(path.resolve(__dirname, 'dist'), ['/', '/about'])],
    };
  },
};
