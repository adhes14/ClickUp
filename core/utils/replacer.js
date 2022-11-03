const logger = require('./logger_manager');

class Replacer {
    /**
     * It replaces a key by its value on nested objects
     * @param {* string} valueToReplace, It's the string we want to change replace
     * @param {* object} source, It's a copy of "this" variable
     * @returns It returns a vuale
     */
    replaceNestedValue(valueToReplace, source) {
        const regex = RegExp(/\(.+\)/g);
        if (!regex.test(valueToReplace)) return valueToReplace;
        const foundMatches = valueToReplace.match(regex);
        let valueReplaced = valueToReplace;
        for (const match of foundMatches) {
            const matchValue = match;
            const splittedValues = matchValue.match(/\w+/g);
            let actualValue = source;
            splittedValues.forEach(nestedKey => {
                if (!Number.isNaN(Number(nestedKey))) actualValue = actualValue[parseInt(nestedKey)];
                else actualValue = actualValue[nestedKey] ?? '';
            });
            logger.info(`Replacing values ${matchValue} to ${actualValue}`);
            valueReplaced = valueReplaced.replace(matchValue, actualValue);
        }
        return valueReplaced;
    }
}

module.exports = new Replacer();
