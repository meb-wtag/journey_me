const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

// Provide jQuery as a global variable
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
  })
);

module.exports = environment;
