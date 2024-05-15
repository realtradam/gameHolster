const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
	content: [
		'./public/*.html',
		'./app/helpers/**/*.rb',
		'./app/javascript/**/*.js',
		'./app/javascript/**/*.jsx',
		'./app/views/**/*.{erb,haml,html,slim}'
	],
	theme: {
		extend: {
			backgroundImage: {
				'star': "url('/img/star.png')",
			},
			fontFamily: {
				sans: ['Inter var', ...defaultTheme.fontFamily.sans],
			},
		},
	},
	plugins: [
		require('@tailwindcss/forms'),
		require('@tailwindcss/aspect-ratio'),
		require('@tailwindcss/typography'),
		require('@tailwindcss/container-queries'),
	]
}
