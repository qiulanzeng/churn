# churn

## 1. In terminal, Training and saving scikit-learn model
- configure aws
- uv add scikit-learn pandas requests
- uv run python train.py

## 2. Creating and testing AWS Lambda function
- AWS Lambda -> Functions -> Create function -> Author from scratch -> Function name (eg. churn-prediction) -> Runtime (Python 3.13) -> Create function
- Test -> Create new test enviroment -> Event name (eg. test) -> Save -> Invoke

## 3. build docker image
docker build -t churn-prediction-lambda .

## 4. run image
docker run -it --rm -p 8080:8080  churn-prediction-lambda

## 5. open another terminal
python test.py

## 6. after testing ok, delete function name in aws console. 

## 6. create an image in ECR
aws ecr create-repository \
  --repository-name "churn-prediction-lambda" \
  --region "ca-central-1"

## 7. push image to ECR
- ECR_URL=607007849765.dkr.ecr.ca-central-1.amazonaws.com/churn-prediction-lambda

- Login to that repo with Docker:
  - aws ecr get-login-password   --region "ca-central-1" | docker login   --username AWS   --password-stdin ${ECR_URL}

- tag the docker image with a special tag, and push it to ECR
  - REMOTE_IMAGE_TAG="${ECR_URL}:v1"
    docker buildx build --platform linux/amd64 -t churn-prediction-lambda .
    docker tag churn-prediction-lambda ${REMOTE_IMAGE_TAG}
    docker push ${REMOTE_IMAGE_TAG}
## 7. run deploy.sh

## 8. in terminal, install boto3
## 9. in terminal, run ./deploy.sh