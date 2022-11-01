const { After, Before } = require('@cucumber/cucumber');
const RequestManager = require('../../../core/api/RequestManager');
const logger = require('../../../core/utils/logger_manager');
const spaceApi = require('../../../main/api/space_api');
const FileReader = require('../../../core/utils/file_reader');
const { buildPath } = require('../../../core/utils/path_builder');
const FolderApi = require('../../../main/api/folder_api');

/**
 * It gets workspace team id, takes the first found
 */
Before({ tags: "@getTeamId" }, async function () {
    logger.info('Getting a team id...');
    const response = await RequestManager.send('GET', '/team', {}, {}, 'owner');
    this.team = response.data.teams[0];
});

/**
 * It gets the user id
 */
Before({ tags: "@getAssigneeId" }, async function () {
    logger.info('Getting a Assignee id...');
    const response = await RequestManager.send('GET', '/user', {}, {}, 'owner');
    this.user = response.data.user;
});

/**
 * It creates a space due to use it later on a step or a hook
 */
Before({ tags: "@createSpace" }, async function () {
    logger.info('Creating a space hook...');
    const spacePath = buildPath("main/resources/createSpace.json");
    const spaceJson = FileReader.readJson(spacePath);
    const response = await spaceApi.create(this.team.id, "", spaceJson);
    this.space = response.data;
});

/**
 * It creates a folder due to use it later on a step or a hook
 */
Before({ tags: "@createFolder" }, async function () {
    logger.info('Creating a folder hook...');
    const response = await FolderApi.create(this.space.id, {"name": "New Test Folder"})
    this.folder = response.data;
});

/**
 * It deletes a space which has been created before, it also deletes a space which has been created into a hook
 */
After ({tags: "@deleteSpace"}, async function () {
    logger.info("Delete Space hook...");
    if (this.space === undefined)
        await spaceApi.delete(this.response.data.id);
    else
        await spaceApi.delete(this.space.id);
});

Before ({tags: "@deleteSpaceB"}, async function () {
    logger.info("Delete Space hook...");
    if (this.space === undefined)
        await spaceApi.delete(this.response.data.id);
    else
        await spaceApi.delete(this.space.id);
});

/**
 * It deletes a folder which has been created before
 */
After({ tags: "@deleteFolder" }, async function () {
    logger.info('Deleting folder hook...');
    if (this.folder === undefined)
        await FolderApi.delete(this.response.data.id);
    else
        await FolderApi.delete(this.folder.id);
});

/**
 * It deletes a goal which has been created before
 */
After({ tags: "@deleteGoal" }, async function () {
    logger.info('Deleting goal hook...');
    if (this.goal === undefined)
        await RequestManager.send('DELETE', `/goal/${this.response.data.goal.id}`, {}, {}, 'owner');
    else
        await RequestManager.send('DELETE', `/goal/${this.goal.goal.id}`, {}, {}, 'owner');
});

/**
 * It deletes a list which has been created before
 */
After ({tags: "@deleteList"}, async function () {
    logger.info("Delete List hook...");
    await RequestManager.send('DELETE', `/list/${this.response.data.id}`, {}, {}, 'owner');
});

/**
 * It creates a list to be used later on a step or a hook
 */
Before({ tags: "@createList" }, async function () {
    logger.info('Creating a list hook...');
    const response = await RequestManager.send('POST', `/folder/${this.folder.id}/list`, {}, {"name": "New List","content": "New List Content","due_date": "1567780450202","due_date_time": "false","priority": "1","assignee": `${this.user.id}`,"status": "red"}, 'owner');
    this.list = response.data;
});

/**
 * It creates a goal to be used later on a step or a hook
 */
Before({ tags: "@createGoal" }, async function () {
    logger.info('Creating a goal...');
    const newGoalBody = {
        "name": "new goal from huk",
        "due_date": "1568036964079",
        "description": "Some description here.....",
        "multiple_owners": false, "color": "#32a852"
    };
    const response = await RequestManager.send('POST', `/team/31589353/goal`, {}, newGoalBody, 'owner');
    this.goal = response.data;
});
