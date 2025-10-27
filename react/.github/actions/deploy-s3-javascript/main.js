/* NOTE dependencies & .gitignore the workflows actions file needs to include ALL files
cd .github/actions/deploy-s3-javascript
npm install @actions/core @actions/exec @actions/github
*/

const core = require('@actions/core');
// const github = require('@actions/github');
const exec = require('@actions/exec');

function run() {
  // 1) Get some input values
  const bucket = core.getInput('bucket', { required: true });
  const bucketRegion = core.getInput('bucket-region', { required: true });
  const distFolder = core.getInput('dist-folder', { required: true });

  // 2) Upload files: COMMENTED OUT FOR TESTING WITHOUT AWS
  //const s3Uri = `s3://${bucket}`;
  //exec.exec(`aws s3 sync ${distFolder} ${s3Uri} --region ${bucketRegion}`);

  const websiteUrl = `http://${bucket}.s3-website-${bucketRegion}.amazonaws.com`;
  core.setOutput('website-url', websiteUrl); // echo "website-url=..." >> $GITHUB_OUTPUT
}

run();
