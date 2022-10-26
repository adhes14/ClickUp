const fileReader = require('./file_reader');
class ConfigurationManager {
    static setUp = fileReader.readJson('./configurationFile.json');
    static environment = fileReader.readJson('./environment.json')[ConfigurationManager.setUp.environment];
}
module.exports = ConfigurationManager;