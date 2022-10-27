const axios = require('axios');
const ConfigurationManager = require('../utils/configuration_manager');

class RequestManager {
    async send(verb, endpoint, header, body) {
        const options = {
            url: `${ConfigurationManager.environment.apiUrl}${endpoint}`,
            method: verb,
            headers: header,
            data: body
        };
        const response = await axios.request(options);
        return response;
    }
}

module.exports = new RequestManager();