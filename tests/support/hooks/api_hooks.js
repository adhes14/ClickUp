const { Before, After } = require('@cucumber/cucumber');
const RequestManager = require('../../../core/api/RequestManager');

/**
 * It deletes a folder which has been created before
 */
After({ tags: "@deleteFolder" }, async function () {
    console.log('Deleting folder hook...');
    await RequestManager.send('DELETE', `/folder/${this.response.data.id}`, {}, {}, 'owner');
});