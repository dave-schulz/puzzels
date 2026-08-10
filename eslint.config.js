import antfu from '@antfu/eslint-config'

export default antfu({
  yaml: false,
  formatters: true,
  typescript: true,
  vue: true,
  rules: {
    'object-curly-newline': [
      'error',
      {
        ObjectExpression: {
          multiline: true,
          minProperties: 1,
        },
        ObjectPattern: {
          multiline: true,
          minProperties: 1,
        },
        ImportDeclaration: {
          multiline: false,
        },
        ExportDeclaration: {
          multiline: false,
        },
      },
    ],
    'array-bracket-newline': [
      'error',
      {
        multiline: true,
        minItems: 1,
      },
    ],
    'object-curly-spacing': [
      'error',
      'always',
    ],
    'array-bracket-spacing': [
      'error',
      'always',
    ],
  },
})
