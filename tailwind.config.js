module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('flowbite/plugin')
  ],
  safelist: [
    'text-green-800',
    'text-red-800',
    'text-green-600',
    'text-red-600',
    'bg-green-200',
    'bg-red-200'
  ],
}
