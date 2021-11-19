# purescript-react-halo-basic-hooks-mui-examples

Purescript React / Halo / Basic Hooks / MUI examples translated from Halogen examples.

See:

* [Halogen](https://pursuit.purescript.org/packages/purescript-halogen)
* [React Halo](https://pursuit.purescript.org/packages/purescript-react-halo)
* [React Basic Hooks](https://pursuit.purescript.org/packages/purescript-react-basic-hooks)
* [React Basic](https://pursuit.purescript.org/packages/purescript-react-basic)
* [Material-UI / MUI](https://github.com/purescript-react-basic-mui/purescript-react-basic-mui)

## Building & Running Examples

Each of the `React Halo` examples are taken from `Halogen` and self-contained in a directory containing the source code and an `index.html` file that you can open in your browser once the source is compiled with `spago` and bundled (with `parceljs` or other, to fix JS FFI references to `require()` in particular in `React Basic` and `MUI` modules).

Make sure dependencies are installed:

```sh
npm install
```

Now you can build any of the examples from the root of the repository using the command `npm run example-<name>`:

```text
npm run example-ace
npm run example-basic
# ...
```

This will compile the example source code into a file named `example.js` in the `dist` directory for the example. You can now open the corresponding `index.html` file from the same directory.

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
spago --config examples/basic/spago.dhall build ; parcel build --no-source-maps examples/basic/dist/index-dev.html
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

To use assets locally (no CDN) they need to be included by the bundler, with possibly different strategies depending on option 1 or 2 above (see the `index.html` & `index-dev.html` files in `examples/basic/dist`).
