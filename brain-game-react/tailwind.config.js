/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        'game': ['Fredoka One', 'cursive'],
        'body': ['Nunito', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
