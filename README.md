# Gentlestudent Webapplication
Webapplication for Gentlestudent

## How to run project
1. Change directory `cd app`
1. Install yarn or npm `yarn` or `npm i` (Don't have yarn? Click [here](https://yarnpkg.com/en/docs/install))
1. Run scss watcher `yarn watch-css` or `npm run watch-css`
1. Open new tab and run `yarn start` or `npm run start`

## Known errors
- If you get an error similar to: `Cannot read property 'apply' of undefined in createStore` => remove the line `compose( devTools )` from the variable `let store` in `store.js`.
