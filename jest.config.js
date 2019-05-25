module.exports = {
    globals: {
        'ts-jest': {
          diagnostics: false
        }
    },
    testRegex: '/__tests__/.*[sS]pec\\.([jt]s)$',
    testURL: 'http://localhost/',
    transform: {
        '^.+\\.(ts|tsx)$': 'ts-jest',
        '^.+\\.twig$': '<rootDir>/testsetup/melody-transform.js',
        '^.+\\.jsx?$': 'babel-jest',
    },
    moduleFileExtensions: ['ts', 'js', 'json'],
    modulePaths: ['<rootDir>/packages'],
    setupFiles: [
        '<rootDir>/testsetup/requestAnimationFrame.js',
        '<rootDir>/testsetup/document.createRange.js',
    ],
    coverageReporters: ['json', 'lcov', 'text-summary', 'html'],
    collectCoverageFrom: [
        'packages/melody-hoc/**',
        'packages/melody-runtime/**',
        'packages/melody-code-frame/**',
        'packages/melody-idom/**',
        'packages/melody-compiler/**',
        'packages/melody-component/**',
        'packages/melody-loader/**',
        'packages/melody-plugin-jsx/**',
        'packages/melody-plugin-skip-if/**',
        'packages/melody-plugin-load-functions/**',
        'packages/melody-jest-transform/**',
        'packages/melody-redux/**',
        'packages/melody-util/**',
        '!**/*.json',
    ],
    coveragePathIgnorePatterns: [
        '/node_modules/',
        '/__tests__/',
        '/__fixtures__/',
        '/lib/',
        '/build/',
        'built/',
        '/testsetup/',
    ],
    coverageThreshold: {
        global: {
            statements: 89,
            branches: 80,
            functions: 91,
            lines: 89,
        },
    },
};
