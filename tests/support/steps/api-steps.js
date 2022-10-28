const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('expect');
const logger = require('../../../core/utils/logger_manager');
const RequestManager = require('../../../core/api/RequestManager');
const { validateSchemaFromPath } = require('../../../core/utils/schema_validator');
const { cwd } = require('process');

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

/**
 * Sets type of user, verb type and the endpoint of the request
 */
When("the {string} user sends a {string} request to {string} endpoint", async function(user, verb, endpoint) {
    this.response =  await RequestManager.send(verb, endpoint, {}, this.requestBody, user);
});

/**
 * Verify if the response code status is the same as expected
 */
Then("the response status code should be {int}", function (expectedCodeStatus) {
    logger.debug(this.response.data, expectedCodeStatus);
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


Then("the response body of the goal should have the following values:", function (table) {
    const tableValues = table.raw();
    for (let index = 0; index < tableValues.length; index++) {
        const value = tableValues[index];
        expect(this.response.data.goal[value[0]].toString()).toBe(value[1]);
    }
});

/**
 * It validates schema of any resource
 */
Then("the schema response is verified with {string}", function (schemaName) {
    const schemaPath = `${cwd()}/main/resources/${schemaName}.json`;
    logger.info(`Verifying schema on ${schemaPath}`);
    expect(validateSchemaFromPath(this.response.data, schemaPath)).toBeTruthy();
});