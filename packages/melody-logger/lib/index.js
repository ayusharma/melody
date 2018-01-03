'use strict';

function _classCallCheck(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
        throw new TypeError('Cannot call a class as a function');
    }
}

/*eslint no-console: [0,{ allow: ["warn"] }] */

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

/**
 * Melody loggers
 */
var Logger =
    /**
 * Constructor
 * @param {object} option 
 */
    function Logger() {
        var _this = this;

        var option =
            arguments.length > 0 && arguments[0] !== undefined
                ? arguments[0]
                : {};

        _classCallCheck(this, Logger);

        ['warn', 'error', 'info', 'log'].forEach(function(curr) {
            _this[curr] = option[curr] || console[curr];
        });
    };

module.exports = Logger;
