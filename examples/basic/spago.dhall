let config = ../../spago.dhall

in config // {
  sources = [ "examples/basic/**/*.purs" ],
  dependencies = config.dependencies
}
