# purescript-react-halo-basic-hooks-mui-examples

Purescript React / Halo / Basic Hooks / MUI examples translated from Halogen examples. Or Preact.

See:

* [Halogen](https://pursuit.purescript.org/packages/purescript-halogen)
* [React Halo](https://pursuit.purescript.org/packages/purescript-react-halo)
* [React Basic Hooks](https://pursuit.purescript.org/packages/purescript-react-basic-hooks)
* [React Basic](https://pursuit.purescript.org/packages/purescript-react-basic)
* [Material-UI / MUI](https://github.com/purescript-react-basic-mui/purescript-react-basic-mui)

## Building & Running Examples

Each of the `React Halo` examples are taken from `Halogen` and self-contained in a directory containing the source code, an `index.html` file, and run script in `package.json`.

The `Halogen` project is pure PureScript so can be bundled with `spago` alone.

The `purescript-react-basic` and `purescript-react-basic-mui` projects used here rely on foreign JS libs (React/Preact/MUI) so need an additional JS bundling step such as with `parceljs`.
This JS bundling step will fix JS FFI `require()` references in `React Basic` and `MUI` modules.

Make sure dependencies are installed:

```sh
npm install
```

Now you can build any of the examples from the root of the repository using the command `npm run examples-<name>`:

```sh
# TODO: need to update for latest ace -- npm run examples-ace
npm run examples-basic
# ...
```

This will compile the example source code into a file named `example.js` in the `dist` directory for the example. You can now open the corresponding `index.html` file from the same directory.

### Development mode with HMR

To build and run the scripts in development mode, run `spago` to build and watch `.purs` files in one terminal shell, and `parcel` to serve with hot-module-reloading in another:

```sh
npm run examples-basic-watch
```

```sh
npm run examples-basic-serve
```

## Halogen Examples

The [Halogen Examples](https://github.com/purescript-halogen/purescript-halogen/tree/master/examples) folder contains a variety of examples demonstrating different Halogen features. You can compile the halogen examples with `spago` from the root of the project (because they contain no JS FFI referencing `require()`).

## Bundled sizes with spago vs parcel

### Bundling with `@react` dependency

Bundling & tree-shaking purescript with `spago bundle-app` and bundling/tree-shaking JS with `parcel build` resulted in ~**280K** JS file:

```bash
spago --config examples/basic/spago.dhall bundle-app --main Example.Basic.Main --to examples/basic/dist/example.js ; parcel build --no-source-maps examples/basic/dist/index.html
```
Building purescript with `spago build` and bundling/tree-shaking JS with `parcel build` resulted in ~**770K** JS file:

```bash
spago --config examples/basic/spago.dhall build ; parcel build --no-source-maps examples/basic/dist/index.html
```
Note:

The first option seems best for production builds, while the second option is good for dev mode (using a combination of `spago build --watch` and `parcel serve` for hot module reloading).

### Bundling with `@preact` dependency

It may be possible to use [Preact v10+](https://preactjs.com/guide/v10/getting-started#best-practices-powered-by-preact-cli) instead of React.
The production `spago bundle-app` variant resulted in a **170K** vs **280K** file (`preact` version 60% of the size).

Add aliases for `Parcel` to `package.json`:
```json
"alias": {
    "react": "preact/compat",
    "react-dom": "preact/compat",
  },
```
Install `Preact`:
```bash
npm uninstall react react-dom
npm run clean-all
npm install
npm install preact
```

Bundling & tree-shaking purescript with `spago bundle-app` and bundling/tree-shaking JS with `parcel build` resulted in ~**170K** JS file.
Building purescript with `spago build` and bundling/tree-shaking JS with `parcel build` resulted in ~**660K** JS file.


## Bundling Fonts / Assets

To include assets like fonts locally (not via 3rd party CDN) they need to be included by the bundler (see the `index.html` files in `examples/basic/dist`).
