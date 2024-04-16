# Hello

This is just a simple app.

The app is deployed on ECS through CodeDeploy, through the `appspec.yml`.

Whereas `buildspec.yml` is used by CodeBuild to build the Docker image and push to ECR.

## Deploy

The deployment of the app to ECS will be done by CodePipeline, however before doing anything we need to build the Docker image and push to ECR.

- Export AWS_PROFILE
    ```bash
    export AWS_PROFILE=<aws_profile>
    ```

- **Build Docker image**
    ```bash
    make docker.build
    ```

- **Login to ECR**
    ```bash
    make docker.login
    ```

- **Push the image to ECR**
    ```bash
    make docker.push
    ```

For infrastructure deployment please check [this repository](https://github.com/RedeployAB/ecs-bg-deployment-example).
