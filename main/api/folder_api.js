const RequestManager = require('../../core/api/RequestManager');

/**
 * It manages API requests for folder feature
 */
class FolderApi {
    /**
     * Creates a folder
     * @param {number} spaceId, space id in which a folder will be created
     * @param {json} body, object representation of the fields required to create a folder
     * @returns a new folder
     */
    async create(spaceId, body){
        const response = await RequestManager.send('POST', `/space/${spaceId}/folder`, {}, body, 'owner');
        return response;
    }

    /**
     * Deletes a folder
     * @param {number} id, folder id to be deleted
     */
    async delete(id){
        await RequestManager.send('DELETE', `/folder/${id}`, {}, {}, 'owner');
    }
}

module.exports = new FolderApi();