// See: https://v4.mui.com/components/typography/#general
//   Be careful when using this approach. Make sure your bundler doesn't eager load all the font variations (100/300/400/500/700/900, italic/regular, SVG/woff).
//   import '@fontsource/roboto';
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';

if (process.env.NODE_ENV === 'production') {
  // 'parcel build' will include only this code branch (parcel adds process.env.NODE_ENV)
  require('./example.js')
} else {
  // 'parcel serve' will include only this code branch
  var Main = require('../../../output/Example.Basic.Main');

  function main () {
    // See for configuration options: https://github.com/purescript/spago#get-started-from-scratch-with-parcel-frontend-projects
    Main.main();
  }

  // HMR setup. For more info see: https://parceljs.org/hmr.html
  if (module.hot) {
    console.log('Configure HMR');
    module.hot.accept(function () {
      console.log('Reloaded, running main again');
      main();
    });
  }

  console.log('Starting app');

  main();

}
