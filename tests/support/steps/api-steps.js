const { Given, When } = require('@cucumber/cucumber');
const ConfigurationManager = require('../../../core/utils/configuration_manager');

Given("the user sets the following body:", function(dataTable) {
    this.requestBody = dataTable.rowsHash();
});

When("the {string} user sends a {string} request to {string} endpoint", async function(user, verb, endpoint) {
    
});