const { Given } = require('@cucumber/cucumber');

Given("the user sets the following body:", function(dataTable) {
    console.log(dataTable);
});