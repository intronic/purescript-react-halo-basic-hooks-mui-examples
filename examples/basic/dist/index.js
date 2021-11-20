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
