/**
 * Copyright 2017 trivago N.V.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS-IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { compile, toString } from '../src';
import { extension as coreExtension } from 'melody-extension-core';
import idomPlugin from 'melody-plugin-idom';
import { stripIndent } from 'common-tags';
import Logger from 'melody-logger';

const fs = require('fs'),
    path = require('path');

const logger = new Logger();

describe('Compiler', function() {
    getFixtures('success').forEach(({ name, twigPath }) => {
        it('should correctly transform ' + name.replace(/_/g, ' '), function() {
            fixture(twigPath, name);
        });
    });

    getFixtures('error').forEach(({ name, twigPath }) => {
        it('should fail transforming ' + name.replace(/_/g, ' '), function() {
            expect(
                fixture.bind(null, twigPath, name)
            ).toThrowErrorMatchingSnapshot();
        });
    });

    describe('when converting', function() {
        it('expressions to JS', function() {
            const code = stripIndent`
        {% macro item(name) %}
          {{name | default('test') }}
        {% endmacro %}

        {% block test %}
          {% import _self as f %}
          {% for item in items %}
            {{ f.item(item) }}
          {% endfor %}
        {% endblock %}
      `;

            const jsTemplate = compile(
                'test.twig',
                code,
                logger,
                coreExtension,
                idomPlugin,
                {
                    filterMap: {
                        toCase: 'melody-runtime',
                        raw: 'melody-runtime',
                    },
                    functionMap: {
                        yay: 'foo',
                    },
                }
            );
            const jsCode = toString(jsTemplate, code);
            expect(jsCode).toMatchSnapshot();
        });

        it('converts map expressions', function() {
            const code = stripIndent`
        {{ {
            a: "foo",
            "b#{a}": "bar",
            2: 4,
            (a): foo,
        } }}
      `;
            expect(
                toString(
                    compile(
                        'test.twig',
                        code,
                        logger,
                        coreExtension,
                        idomPlugin
                    ),
                    code
                ).code
            ).toMatchSnapshot();
        });

        it('should support dynamic attributes', function() {
            const code =
                '<div class="foo" key="{{ _i ~ _len }}" {{ dataAttributes }}></div>';
            expect(
                toString(
                    compile(
                        'test.twig',
                        code,
                        logger,
                        coreExtension,
                        idomPlugin
                    ),
                    code
                ).code
            ).toMatchSnapshot();
        });
    });

    describe('when translating operators', function() {
        it('should convert the >= operator', function() {
            const code = "{{ saving >= 20 ? 'reduced' : '' }}";
            expect(
                toString(
                    compile(
                        'test.twig',
                        code,
                        logger,
                        coreExtension,
                        idomPlugin
                    ),
                    code
                ).code
            ).toMatchSnapshot();
        });
    });

    describe('displayName', function() {
        const code = '<div/>';
        it('should capitalize file name', function() {
            expect(
                toString(
                    compile(
                        'foo/bar/test.melody.twig',
                        code,
                        logger,
                        coreExtension,
                        idomPlugin
                    ),
                    code
                ).code
            ).toMatchSnapshot();
        });
        it('should take dir name if file name is index', function() {
            expect(
                toString(
                    compile(
                        'foo/bar/index.melody.twig',
                        code,
                        logger,
                        coreExtension,
                        idomPlugin
                    ),
                    code
                ).code
            ).toMatchSnapshot();
        });
        it('should take dir name if file name is base', function() {
            expect(
                toString(
                    compile(
                        'foo/bar/base.melody.twig',
                        code,
                        logger,
                        coreExtension,
                        idomPlugin
                    ),
                    code
                ).code
            ).toMatchSnapshot();
        });
    });

    describe('when traversing the AST', function() {
        it('should have a scope on all nodes', function() {
            const code = '{{ test }} {{ foo }}';
            let testScope, fooScope;
            compile('test.twig', code, logger, coreExtension, idomPlugin, {
                visitors: {
                    analyse: {
                        Identifier(path) {
                            if (path.node.name === 'test') {
                                testScope = path.scope;
                            } else if (path.node.name === 'foo') {
                                fooScope = path.scope;
                            }
                        },
                    },
                },
            });
            expect(Object.keys(fooScope.bindings)).toEqual([
                '_context',
                'test',
                'foo',
                '_template',
            ]);
            expect(testScope === fooScope).toEqual(true);
        });
    });

    describe('when a target plugin is missing', function() {
        it('should throw an error', function() {
            const code = '<div/>';
            expect(() =>
                compile('test.twig', code, logger, coreExtension)
            ).toThrowErrorMatchingSnapshot();
        });
        it('should throw an error', function() {
            const code = 'foo';
            expect(() =>
                compile('test.twig', code, logger, coreExtension)
            ).toThrowErrorMatchingSnapshot();
        });
        it('should throw an error', function() {
            const code = '{% include "foo.twig" %}';
            expect(() =>
                compile('test.twig', code, logger, coreExtension)
            ).toThrowErrorMatchingSnapshot();
        });
    });
});

function getFixtures(type) {
    const dirPath = path.join(__dirname, '__fixtures__', type);
    return fs.readdirSync(dirPath).map(name => ({
        name: path.basename(name, '.twig'),
        twigPath: path.join(dirPath, name),
    }));
}

function fixture(twigPath, name) {
    const twig = fs.readFileSync(twigPath).toString();

    const jsAst = compile(
        name + '.twig',
        twig,
        logger,
        coreExtension,
        idomPlugin
    );

    const actual = toString(jsAst, twig).code;

    expect(`\n${actual}\n`).toMatchSnapshot();
}
