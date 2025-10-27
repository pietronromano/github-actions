# RESULTS: COULDN'T CREATE REPO WITH CLI & GH_TOKEN, ONLY WORKED WITH A PAT in API call
- Run REPO_URL=$(gh repo create "$REPO_OWNER/$REPO_NAME" --private --clone)
   GraphQL: Resource not accessible by integration (createRepository)
   Error: Process completed with exit code 1.

- see: (mentions Graphql)
  - https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/authenticating-as-a-github-app-installation#about-authentication-as-a-github-app-installation


# Kaufmann, Michael. GitHub Actions Cookbook: (pp. 240-241). (Function). Kindle Edition.
# Go to https://github.com/settings/apps and click New GitHub App. 
# Give it a unique name (i.e., {your username}-repo-creation) and set Homepage URL to the URL of your repository. 
- pnr-repo-creation
- https://github.com/pietronromano/github-actions-issues
- App ID: 2115486
- Client ID: Iv23lilDI21puu4oPOHK

# Under Repository permissions, select 
- Administration: Read and write, 
- Contents: Read and write, 
- Issues: Read and write, 
- and under Organization permissions, select Administration: read and write. 

# Save the app. In your newly created app, click on Generate a private key. The private key will be automatically downloaded.
- Paste ALL the private key, including the --BEGIN and --END...

# IMPORTANT: Install the app!
- In the​ app in GitHub, select Install App and click Install. Pick your organization or account, click install, leave All repositories selected, and click Install. 

# Go back to the environment in your repository. Add a new secret PRIVATE_KEY and add the content of the key file you downloaded earlier. Also, add an APP_ID variable with the ID of your app (see Figure 5.8).

