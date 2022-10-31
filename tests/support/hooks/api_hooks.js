const { After, Before } = require('@cucumber/cucumber');
const RequestManager = require('../../../core/api/RequestManager');
const logger = require('../../../core/utils/logger_manager');
const fileReader = require('../../../core/utils/file_reader');
const spaceApi = require('../../../main/api/space_api')

/**
 * It deletes a folder which has been created before
 */
After({ tags: "@deleteFolder" }, async function () {
    logger.info('Deleting folder hook...');
    await RequestManager.send('DELETE', `/folder/${this.response.data.id}`, {}, {}, 'owner');
});

Before ({tags: "@createSpace"}, async function () {
    logger.info('Creating space hook...');
    const spaceJson = fileReader.readJson("main/resources/spaceBody.json");
    this.space = await spaceApi.create("", "", spaceJson, "");
});

After ({tags: "@deleteSpace"}, async function () {
    logger.info("Delete Space hook...");
    await spaceApi.delete(this.response.data.id);
});


