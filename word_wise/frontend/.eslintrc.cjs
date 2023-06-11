module.exports = {
  root: true,
  env: {
    node: true,
    browser: true
  },
  // include: ['src/**/*', 'src'],
  ignorePatterns: [
    '*.env',
    '**capacitor.config**',
    '**vite.config**',
    '**package-lock**',
    '**eslintrc**'
  ],
  extends: [
    'standard-with-typescript',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'plugin:react/jsx-runtime',
    'plugin:@typescript-eslint/recommended-requiring-type-checking'
    // 'plugin:@typescript-eslint/recommended'
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 2020,
    parser: '@typescript-eslint/parser',
    project: './tsconfig.json',
    tsconfigRootDir: __dirname,
    sourceType: 'module'
  },
  plugins: ['react', 'react-hooks', '@typescript-eslint'],
  settings: {
    react: {
      version: 'detect'
    }
  },
  rules: {
    'spaced-comment': 'off',
    '@typescript-eslint/no-misused-promises': 'warn', // 'off'
    '@typescript-eslint/no-unsafe-member-access': 'warn',
    '@typescript-eslint/no-unsafe-argument': 'warn',
    '@typescript-eslint/no-unsafe-assignment': 'warn',
    '@typescript-eslint/no-unused-vars': 'warn',
    'padded-blocks': 'warn',
    'no-trailing-spaces': 'warn',
    'react/prop-types': 'off',
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': [
      'warn',
      {
        additionalHooks: '(useMyCustomHook|useMyOtherCustomHook)'
      }
    ],
    'react/jsx-no-useless-fragment': 'warn',
    'react/button-has-type': 'warn',
    'react/display-name': 'warn',
    'react/no-children-prop': 'warn',
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off'
  }
}
