const logger = require('./logger_manager');

module.exports.replaceValue = function (valueToReplace, source) {
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
};
