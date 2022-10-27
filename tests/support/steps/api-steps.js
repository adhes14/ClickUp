const { Given, When, Then } = require('@cucumber/cucumber');
const axios = require('axios');
const { expect } = require('expect');
const ConfigurationManager = require('../../../core/utils/configuration_manager');

/**
 * Sets a body object for an API request
 */
Given("the user sets the following body:", function(dataTable) {
    this.requestBody = dataTable.rowsHash();
});

/**
 * Sets type of user, verb type and the endpoint of the request
 */
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

/**
 * Verify if the response code status is the same as expected
 */
Then("the response status code should be {int}", function (expectedCodeStatus) {
    console.log(this.response.data, expectedCodeStatus);
    expect(this.response.status).toBe(expectedCodeStatus);
});

/**
 * Sets a 2 dimension array for a response, and verify one by one if it is the same as expected
 */
Then("the response body should have the following values:", function (table) {
    const tableValues = table.raw();
    for (let index = 0; index < tableValues.length; index++) {
        const value = tableValues[index];
        expect(this.response.data[value[0]].toString()).toBe(value[1]);
    }
});