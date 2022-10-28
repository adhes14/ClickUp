/**
 *
 * @param {* It's a copy of "this" variable} worldVar
 * @param {* It's the endpoint we want to change, replacing string feature id with its numeric representation} endpoint
 * @returns
 */
module.exports.modifyEndpoint = (worldVar, endpoint) => {
    if (endpoint.includes('(')) {
        const regEx = /\(([^)]+)\)/;
        const replace = regEx.exec(endpoint)[0];
        const featureId = regEx.exec(endpoint)[1];
        return endpoint.replace(replace, worldVar[featureId]);
    } else {
        return endpoint;
    }
}
