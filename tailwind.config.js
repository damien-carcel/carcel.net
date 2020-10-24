module.exports = {
  future: {
    // removeDeprecatedGapUtilities: true,
    // purgeLayersByDefault: true,
  },
  purge: {
    mode: 'layers',
    layers: ['components', 'utilities'],
    content: ['./src/**/*.ejs'],
  },
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
}
