# p. 194 Kaufmann, Michael. GitHub Actions Cookbook: A practical guide to automating repetitive tasks and streamlining your development process (p. 194). (Function). Kindle Edition. 

# Auto-scaling self-hosted runners In this ​recipe, we’ll be building on the previous recipe ​so that we have a solution that automatically starts a new instance of the ephemeral Docker container every time a new workflow is triggered. 
# We’ll use a GitHub webhook for that.

# Go to https://github.com/settings/apps and click on New GitHub App. 
# Set GitHub App Name to auto-scale-runners and Homepage URL to the URL of the repository you are using (see Figure 4.6):
pnr-auto-scale-runners
https://github.com/pietronromano/github-actions-runners/

# Open another ​browser tab, go to https://smee.io, and click on Start new channel. 
# Copy the Webhook Proxy URL value. Go back to the other tab and paste the URL into the Webhook URL field. 
# Set Webhook secret to a string that you will remember later (see Figure 4.7):
https://smee.io/Ku223Ne4Hw2ieAW2
- App ID: 2114388
- Client ID: Iv23lijXuNfCVoS5B55I

# Next, we will ​create the server that will run when it receives a payload from the ​webhook
npm install octokit
npm install dotenv
npm install smee-client --save-dev 

# Add the node_modules folder to.gitignore:
echo "node_modules" >> .gitignore 

# Create a new file called app.js. (see code)

# In the package.json file, add a top-level entry called type and set it to module. Then, add a​ script called server that ​will run the application: "type": "module",
"scripts": {
  "server": "node app.js"
}, 

# We are ready! Open a new terminal and start a smee client with the URL of your channel (Step 4): 
cd auto-scale
npx smee -u https://smee.io/2114388 -t http://localhost:3000/api/webhook 

# In another terminal, run the app: 
cd auto-scale
npm run server 

# Start a new workflow run for the Self-Hosted workflow: 
gh workflow run Self-Hosted 

# Note how your smee client receives the webhook that was forwarded from GitHub and how your server processes it and starts a new container that executes your workflow.

