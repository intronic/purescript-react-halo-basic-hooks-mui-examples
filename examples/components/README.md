# Components

This example demonstrates a button component embedded in a parent component. The parent component can send queries to and receive output messages from the button.

## Building

You can build this example from the root of the Halogen project:

```sh
npm install
npm run example-components
```

This will bundle a runnable JS file, `example.js`, in the `examples/components/dist` directory. You can view the running application by opening the corresponding `index.html` file.

## Query, Input, Output -> Props & Context

`Halogen` `Query`, `Input` & `Output` are missing from `React.Halo` and can be replaced with `Props` & `Context`, where:
* parent -> child messages can be replaced with Props & Context vars
* child -> parent messages can be replaced with Context callbacks
