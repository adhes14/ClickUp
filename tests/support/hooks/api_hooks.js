const { Before, After } = require('@cucumber/cucumber');
const RequestManager = require('../../../core/api/RequestManager');
const logger = require('../../../core/utils/logger_manager');
const { cwd } = require('process');
const path = require('path');
const FileReader = require('../../../core/utils/file_reader');

/**
 * It deletes a folder which has been created before
 */
After({ tags: "@deleteFolder" }, async function () {
    logger.info('Deleting folder hook...');
    await RequestManager.send('DELETE', `/folder/${this.response.data.id}`, {}, {}, 'owner');
});

/**
 * It deletes a space which has been created before
 */
After ({tags: "@deleteSpace"}, async function () {
    logger.info("Delete Space hook...");
    await RequestManager.send('DELETE', `/space/${this.response.data.id}`, {}, {}, 'owner');
    this.space.id ? await RequestManager.send('DELETE', `/space/${this.space.id}`, {}, {}, 'owner') : '';
});

/**
 * It deletes a goal which has been created before
 */
After({ tags: "@deleteGoal" }, async function () {
    logger.info('Deleting goal hook...');
    await RequestManager.send('DELETE', `/goal/${this.response.data.goal.id}`, {}, {}, 'owner');
});

/**
 * It deletes a list which has been created before
 */
After ({tags: "@deleteList"}, async function () {
    logger.info("Delete List hook...");
    await RequestManager.send('DELETE', `/list/${this.response.data.id}`, {}, {}, 'owner');
});

Before({ tags: "@getTeamId" }, async function () {
    logger.info('Getting a team id...');
    const response = await RequestManager.send('GET', '/team', {}, {}, 'owner');
    this.teamId = response.data.teams[0].id;
});

Before({ tags: "@createSpace" }, async function () {
    logger.info('Creating a speace...');
    const spacePath = `${cwd()}${path.sep}main${path.sep}resources${path.sep}createSpace.json`;
    const spaceJson = FileReader.readJson(spacePath);
    const response = await RequestManager.send('POST', `/team/${this.teamId}/space`, {}, spaceJson, 'owner');
    this.space = response.data;
})
