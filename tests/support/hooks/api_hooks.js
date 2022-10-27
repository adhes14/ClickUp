const { Before, After } = require('@cucumber/cucumber');
const ConfigurationManager = require('../../../core/utils/configuration_manager');
const axios = require('axios');

/**
 * It deletes a folder which has been created before
 */
After({ tags: "@deleteFolder" }, async function () {
    console.log('Deleting folder hook...');
    const header = ConfigurationManager.environment.users['owner'];
    const options = {
        url: `${ConfigurationManager.environment.apiUrl}/folder/${this.response.data.id}`,
        method: 'DELETE',
        headers: header,
        validateStatus: undefined
    };
    console.log(options);
    await axios.request(options);
});