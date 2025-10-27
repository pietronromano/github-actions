# Use a dockerfile

## Variables
app="github-runner"
img="img-"$app
cnt="cnt-"$app
TOKEN=...
RUNNER_URL=https://github.com/pietronromano/github-actions-runners
RUNNER_NAME=my-runner-
instance=1
instance=2
instance=3

 
# Build the image: don't forget the (.) period at the end
docker build --platform linux/x86_64 -f Dockerfile -t $img .

# Run detached in background (can run several with different names)
docker run -d --platform linux/x86_64 \
    --name $cnt$instance \
    -e RUNNER_NAME=$RUNNER_NAME$instance \
    -e TOKEN=$TOKEN \
    -e RUNNER_URL=$RUNNER_URL \
    $img

# Examine the running instance
docker container exec -it $cnt$instance bash
# From inside:
cd /home/docker/actions-runner/_work/github-actions-runners/github-actions-runners

cd /home/docker/actions-runner
./config.sh remove --token ...
