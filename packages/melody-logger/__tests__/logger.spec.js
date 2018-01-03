/*eslint no-console: [0,{ allow: ["warn"] }] */

import Logger from '../src';

describe('Logger  with no configuration', () => {
    let logger;
    console.warn = jest.fn();
    console.error = jest.fn();
    console.info = jest.fn();
    console.log = jest.fn();

    beforeEach(() => {
        logger = new Logger();
    });

    it('should called the warn method', () => {
        logger.warn('test warning');
        expect(console.warn).toHaveBeenCalledWith('test warning');
    });

    it('should called the error method', () => {
        logger.error('test error');
        expect(console.error).toHaveBeenCalledWith('test error');
    });

    it('should called the info method', () => {
        logger.info('test info');
        expect(console.info).toHaveBeenCalledWith('test info');
    });

    it('should called the log method', () => {
        logger.log('test log');
        expect(console.log).toHaveBeenCalledWith('test log');
    });
});

describe('Logger  with configuration', () => {
    let logger;
    const config = {
        warn: jest.fn(),
        error: jest.fn(),
        info: jest.fn(),
        log: jest.fn(),
    };

    beforeEach(() => {
        logger = new Logger(config);
    });

    it('should called the warn method', () => {
        logger.warn('test warning');
        expect(config.warn).toHaveBeenCalledWith('test warning');
    });

    it('should called the error method', () => {
        logger.error('test error');
        expect(config.error).toHaveBeenCalledWith('test error');
    });

    it('should called the info method', () => {
        logger.info('test info');
        expect(config.info).toHaveBeenCalledWith('test info');
    });

    it('should called the log method', () => {
        logger.log('test log');
        expect(config.log).toHaveBeenCalledWith('test log');
    });
});
