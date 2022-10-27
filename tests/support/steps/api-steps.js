const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('expect');
const ConfigurationManager = require('../../../core/utils/configuration_manager');
const RequestManager = require('../../../core/api/request_manager.js');
const logger = require('../../../core/utils/logger_manager');

Given("the user sets the following complete body:", function(dataTable) {
    logger.info("Parsing body string to JSON...");
    this.requestBody = JSON.parse(dataTable);
});

/**
 * Sets a body object for an API request
 */
Given("the user sets the following body:", function(dataTable) {
    this.requestBody = dataTable.rowsHash();
});

When("the {string} user sends a {string} request to {string} endpoint", async function(user, verb, endpoint) {
    const header = ConfigurationManager.environment.users[user];
    this.response = await RequestManager.send(verb, endpoint, header, this.requestBody);
});

Then("the response status code should be {int}", function (expectedCodeStatus) {
    logger.debug(this.response.data, expectedCodeStatus);
    expect(this.response.status).toBe(expectedCodeStatus);
});

Then("the response body should have the following values:", function (table) {
    const tableValues = table.raw();
    for (let index = 0; index < tableValues.length; index++) {
        const value = tableValues[index];
        expect(this.response.data[value[0]].toString()).toBe(value[1]);
    }
});