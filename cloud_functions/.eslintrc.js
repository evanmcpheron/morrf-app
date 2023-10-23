
module.exports = {
  env: {
    es6: true,
    node: true,
  },
  parserOptions: {
    "ecmaVersion": 2018,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    "no-restricted-globals": [
      "error",
      "name",
      "length",
    ],
    "prefer-arrow-callback": "error",
    "quotes": 0,
    "indent": 0,
    "object-curly-spacing": 0,
    "max-len": 0,
    "space-before-function-paren": 0,
    "spaced-comment": 0,
    "trailing-comma": 0,
    "eol-last": 0,
  },
  overrides: [
    {
      files: [
        "**/*.spec.*",
      ],
      env: {
        mocha: true,
      },
      rules: {},
    },
  ],
  globals: {},
};
