const { Given, When } = require('@cucumber/cucumber');
const axios = require('axios');
const ConfigurationManager = require('../../../core/utils/configuration_manager');

Given("the user sets the following body:", function(dataTable) {
    this.requestBody = dataTable.rowsHash();
});

When("the {string} user sends a {string} request to {string} endpoint", async function(user, verb, endpoint) {
    const header = ConfigurationManager.environment.users[user];
    const options = {
        url: `${ConfigurationManager.environment.apiUrl}${endpoint}`,
        method: verb,
        headers: header,
        data: this.requestBody
    };
    console.log(header, options);
    const response = await axios.request(options);
    console.log(response);
});