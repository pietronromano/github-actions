
# DATE: 06-October-2025
# Reused this sample for github actions tests

###############################################################

# How to reuse: Regenerate the node_modules folder according to dependencies in package.json 
cd src
npm install

# Run the app
node nodeapi <inmemory|cosmos|sql>

# Github debug
gh variable set ACTIONS_STEP_DEBUG --body false|true

###############################################################

# How to start from scratch Create a project
npm init

# Express (--save is now the default)
npm install express

# Run and edit on the fly with nodemon (need to install first)
# Mac: had to run SUDO npm install nodemon -g
npm install nodemon -g

# cors
##https://stackoverflow.com/questions/57640113/cors-it-does-not-have-http-ok-status
npm install cors

# Cosmos DB
 - https://docs.microsoft.com/en-us/azure/cosmos-db/sql-api-nodejs-get-started
 -Install the @azure/cosmos module via npm. Use the following command:
npm install @azure/cosmos --save


# Run the app
node nodeapi <inmemory|cosmos|sql>

# Debugging
Add VC code configuration for node

# Set startup file in .vscode\launch.json (in root directory, above nodeapi)
# This works on Mac.. suppose backslash would be needed for Windows


