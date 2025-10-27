# Deploy webapp with Publish Profile
- DATE 20-October-2025
- WORKFLOW: webapp-publish-profile.yml
- ORIGINAL SOURCE: https://docs.microsoft.com/en-us/azure/app-service/deploy-github-actions?tabs=applevel#generate-deployment-credentials
- RESULTS: WORKED FINE, UPDATING actions to: 
  - checkout@v5, cache@v4.3.0, upload-artifact@v4.6.2, download-artifact@v5, webapps-deploy@v2.2.17
- For a list of actions, see: https://github.com/actions

# Prequisites: 
- Create  Azure App Service web app
    - rg: rg-github-actions
    - webapp: pnrghactionswebapp1, .Net 9, linux, northeurope
    - URL: https://pnrghactionswebapp1.azurewebsites.net
    - Enable WebApp Deployment Basic Authentication: 
        - https://learn.microsoft.com/en-us/azure/app-service/deploy-github-actions?tabs=applevel%2Caspnetcore#generate-deployment-credentials
- In workflow, set env.AZURE_WEBAPP_NAME to the name of the webapp
- Create in your repository:
    - An Environment named Development
    - Inside the Environment, a secret named AZURE_WEBAPP_PUBLISH_PROFILE, paste the publish profile contents as the value of the secret.
 