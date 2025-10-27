##########################################################
# Docker 
# Build the docker file

app=gibhub-custom-action-hello
cnt="cnt-"$app
img="img-"$app

# Build
cd ./.github/actions/docker
docker build --platform linux/x86_64 -t $img -f Dockerfile .
docker image ls
docker image rm $img

docker container run \
    --platform linux/x86_64 \
    --name $cnt \
    --rm \
    $img \
    "Argument 1" "Argument 2"
