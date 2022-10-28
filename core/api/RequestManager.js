const axios = require('axios');
const ConfigurationManager = require('../utils/configuration_manager');
const logger = require('../utils/logger_manager');

class RequestManager {
    async send(verb, endpoint, queryParams, body, user) {
        const headers = ConfigurationManager.environment.users[user];
        const options = {
            url: `${ConfigurationManager.environment.apiUrl}${endpoint}`,
            method: verb,
            headers: headers,
            params: queryParams,
            data: body,
            validateStatus: undefined
        };
        logger.debug(`Sending a ${verb} request to ${options.url}`);
        const response = await axios.request(options);
        logger.debug(`Response returned with ${response.status} code`);
        return response;
    }
}

module.exports = new RequestManager();
