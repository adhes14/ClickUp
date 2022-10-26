const { Given, When, Then } = require('@cucumber/cucumber');
const axios = require('axios');
const { expect } = require('expect');
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
    this.response = await axios.request(options);
});

Then("the response status code should be {int}", function (expectedCodeStatus) {
    console.log(this.response.data, expectedCodeStatus);
    expect(this.response.status).toBe(expectedCodeStatus);
});