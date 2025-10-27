PENDING REVIEW
# Date: 9/12/2024
# SOURCE: https://learn.microsoft.com/en-us/azure/app-service/app-service-sql-github-actions

location=westeurope
echo $location

rg="rg-devops"
echo $rg

az group create --name $rg --location $location

# register a new Microsoft Entra ID application and service principal that can access resources.
appName="MyAppDB"
echo $appName

az ad app create --display-name $appName
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
  "addIns": [],
  "api": {
    "acceptMappedClaims": null,
    "knownClientApplications": [],
    "oauth2PermissionScopes": [],
    "preAuthorizedApplications": [],
    "requestedAccessTokenVersion": null
  },
  "appId": "a954cc20-1ebc-49b9-90ca-7b1c0cbcecab",
  "appRoles": [],
  "applicationTemplateId": null,
  "certification": null,
  "createdDateTime": "2024-12-09T12:07:28.0825364Z",
  "defaultRedirectUri": null,
  "deletedDateTime": null,
  "description": null,
  "disabledByMicrosoftStatus": null,
  "displayName": "MyAppDB",
  "groupMembershipClaims": null,
  "id": "595c238f-a02f-4e41-8a99-6f55b7afbd5f",
  "identifierUris": [],
  "info": {
    "logoUrl": null,
    "marketingUrl": null,
    "privacyStatementUrl": null,
    "supportUrl": null,
    "termsOfServiceUrl": null
  },
  "isDeviceOnlyAuthSupported": null,
  "isFallbackPublicClient": null,
  "keyCredentials": [],
  "nativeAuthenticationApisEnabled": null,
  "notes": null,
  "optionalClaims": null,
  "parentalControlSettings": {
    "countriesBlockedForMinors": [],
    "legalAgeGroupRule": "Allow"
  },
  "passwordCredentials": [],
  "publicClient": {
    "redirectUris": []
  },
  "publisherDomain": "pietronromanolive.onmicrosoft.com",
  "requestSignatureVerification": null,
  "requiredResourceAccess": [],
  "samlMetadataUrl": null,
  "serviceManagementReference": null,
  "servicePrincipalLockConfiguration": null,
  "signInAudience": "AzureADMyOrg",
  "spa": {
    "redirectUris": []
  },
  "tags": [],
  "tokenEncryptionKeyId": null,
  "uniqueName": null,
  "verifiedPublisher": {
    "addedDateTime": null,
    "displayName": null,
    "verifiedPublisherId": null
  },
  "web": {
    "homePageUrl": null,
    "implicitGrantSettings": {
      "enableAccessTokenIssuance": false,
      "enableIdTokenIssuance": false
    },
    "logoutUrl": null,
    "redirectUriSettings": [],
    "redirectUris": []
  }
}

## appId  is your client-id
appId="a954cc20-1ebc-49b9-90ca-7b1c0cbcecab"
echo $appId

##  The id is APPLICATION-OBJECT-ID and it will be used for creating federated credentials with Graph API calls. 
appObjectId="595c238f-a02f-4e41-8a99-6f55b7afbd5f"
echo $appObjectId

# Create a service principal. Replace the $appID with the appId from your JSON output.
# This command generates JSON output with a service principal id. The service principal id is used as the value of the --assignee-object-id argument in the az role assignment create command in the next step.
# Copy the appOwnerOrganizationId from the JSON output to use as a GitHub secret for AZURE_TENANT_ID later.

az ad sp create --id $appId
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#servicePrincipals/$entity",
  "accountEnabled": true,
  "addIns": [],
  "alternativeNames": [],
  "appDescription": null,
  "appDisplayName": "MyAppDB",
  "appId": "a954cc20-1ebc-49b9-90ca-7b1c0cbcecab",
  "appOwnerOrganizationId": "599fd2f6-80be-4f0d-9b03-b3e74fdcf211",
  "appRoleAssignmentRequired": false,
  "appRoles": [],
  "applicationTemplateId": null,
  "createdDateTime": "2024-12-09T12:12:38Z",
  "deletedDateTime": null,
  "description": null,
  "disabledByMicrosoftStatus": null,
  "displayName": "MyAppDB",
  "homepage": null,
  "id": "d463d911-7c42-44ae-b547-8978c01bd5fd",
  "info": {
    "logoUrl": null,
    "marketingUrl": null,
    "privacyStatementUrl": null,
    "supportUrl": null,
    "termsOfServiceUrl": null
  },
  "keyCredentials": [],
  "loginUrl": null,
  "logoutUrl": null,
  "notes": null,
  "notificationEmailAddresses": [],
  "oauth2PermissionScopes": [],
  "passwordCredentials": [],
  "preferredSingleSignOnMode": null,
  "preferredTokenSigningKeyThumbprint": null,
  "replyUrls": [],
  "resourceSpecificApplicationPermissions": [],
  "samlSingleSignOnSettings": null,
  "servicePrincipalNames": [
    "a954cc20-1ebc-49b9-90ca-7b1c0cbcecab"
  ],
  "servicePrincipalType": "Application",
  "signInAudience": "AzureADMyOrg",
  "tags": [],
  "tokenEncryptionKeyId": null,
  "verifiedPublisher": {
    "addedDateTime": null,
    "displayName": null,
    "verifiedPublisherId": null
  }
}

# Tenant ID
appOwnerOrganizationId="599fd2f6-80be-4f0d-9b03-b3e74fdcf211"
echo $appOwnerOrganizationId

spId="d463d911-7c42-44ae-b547-8978c01bd5fd"
echo $spId


# Create a new role assignment for your service principal. By default, the role assignment will be tied to your default subscription. Replace $subscriptionId with your subscription ID, $resourceGroupName with your resource group name, and $servicePrincipalId with the newly created service principal id.

subscriptionId="a2401ab8-bd17-453c-a13b-ae728a0271e9"
echo $subscriptionId

## REmove first slash / from --scope to avoid resource provider error
az role assignment create --role contributor --subscription $subscriptionId --assignee-object-id  $spId --assignee-principal-type ServicePrincipal --scope subscriptions/$subscriptionId/resourceGroups/$rg
{
  "condition": null,
  "conditionVersion": null,
  "createdBy": null,
  "createdOn": "2024-12-09T12:18:19.544894+00:00",
  "delegatedManagedIdentityResourceId": null,
  "description": null,
  "id": "/subscriptions/a2401ab8-bd17-453c-a13b-ae728a0271e9/resourceGroups/rg-devops/providers/Microsoft.Authorization/roleAssignments/f10f0977-e44e-463b-8281-8b7cace097fa",
  "name": "f10f0977-e44e-463b-8281-8b7cace097fa",
  "principalId": "d463d911-7c42-44ae-b547-8978c01bd5fd",
  "principalType": "ServicePrincipal",
  "resourceGroup": "rg-devops",
  "roleDefinitionId": "/subscriptions/a2401ab8-bd17-453c-a13b-ae728a0271e9/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
  "scope": "/subscriptions/a2401ab8-bd17-453c-a13b-ae728a0271e9/resourceGroups/rg-devops",
  "type": "Microsoft.Authorization/roleAssignments",
  "updatedBy": "11fd3ee4-4270-468c-b818-ad197363dc36",
  "updatedOn": "2024-12-09T12:18:19.875929+00:00"
}

# Run the following command to create a new federated identity credential for your Microsoft Entra ID application.
 - Replace APPLICATION-OBJECT-ID with the objectId (generated while creating app) for your Microsoft Entra ID application.
 - Set a value for CREDENTIAL-NAME to reference later.
 - Set the subject: repo:n-username/ node_express:ref:refs/heads/my-branch or repo:n-username/ node_express:ref:refs/tags/my-tag.
   - "subject": "repo:pietronromano/dotnetcore-containerized-sqldb-ghactions:refs/heads/main",
   
az ad app federated-credential create --id $appObjectId --parameters credential.json
{
    "name": "AppDBTestCred2",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:pietronromano/dotnetcore-containerized-sqldb-ghactions:ref:refs/heads/main",
    "description": "Testing",
    "audiences": [
        "api://AzureADTokenExchange"
    ]
}
RESULT:
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('595c238f-a02f-4e41-8a99-6f55b7afbd5f')/federatedIdentityCredentials/$entity",
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "description": "Testing",
  "id": "a6f858aa-ea0d-4ca6-bd4e-0d3c9c71d32f",
  "issuer": "https://token.actions.githubusercontent.com",
  "name": "AppDBTestCred",
  "subject": "repo:pietronromano/dotnetcore-containerized-sqldb-ghactions:ref:refs/heads/main"
}

# Configure the GitHub secret for authentication
 - You need to provide your application's Client ID, Tenant ID, and Subscription ID to the login action.
    - AZURE_CLIENT_ID: a954cc20-1ebc-49b9-90ca-7b1c0cbcecab
    - AZURE_TENANT_ID: 599fd2f6-80be-4f0d-9b03-b3e74fdcf211
    - AZURE_SUBSCRIPTION_ID: a2401ab8-bd17-453c-a13b-ae728a0271e9

# Add a SQL Server secret
 - Create a new secret in your repository for SQL_SERVER_ADMIN_PASSWORD
   - SQL_SERVER_ADMIN_PASSWORD: Axml-xsl0123
   - SQL_SERVER_ADMIN_USER: pietronromano   [my addition]



# GOT ERROR: Error: Please make sure to give write permissions to id-token in the workflow.
# Added this and it worked:
    - https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-cloud-providers
permissions:
  id-token: write # This is required for requesting the JWT
  contents: read  # This is required for actions/checkout


  
# Add container registry and SQL secrets
 - In the Azure portal, open your newly created Azure Container Registry in your resource group.
   - Go to Access keys and copy the username and password values.
   - Create new GitHub secrets for ACR_USERNAME and ACR_PASSWORD password in your repository.

 - In the Azure portal, open your Azure SQL database. Open Connection strings and copy the value.
   - Create a new secret for SQL_CONNECTION_STRING. Replace {your_password} with your SQL_SERVER_ADMIN_PASSWORD.
   - ACR_USERNAME: pnracrtodosample
     ACR_PASSWORD ...
     SQL_CONNECTION_STRING: Server=tcp:pnr-sql-todo-sample.database.windows.net,1433;Initial Catalog=sqldb-todo;Persist Security Info=False;User ID=pietronromano;Password=...;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;


# GOT ERROR AGAIN: Error: Please make sure to give write permissions to id-token in the workflow.
# Added this and it worked:
    - https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-cloud-providers
permissions:
  id-token: write # This is required for requesting the JWT
  contents: read  # This is required for actions/checkout