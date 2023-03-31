FROM alpine:3.14

# set ARGS
ARG AWS_KEY=''
ARG AWS_SECRET_KEY=''
ARG AWS_REGION=''

RUN apk add nodejs && \
    apk add npm && \ 
    apk add yarn && \ 
    apk add --no-cache aws-cli && \ 
    apk add bash;

WORKDIR /app

# aws configure
RUN aws configure set aws_access_key_id $AWS_KEY \ 
&& aws configure set aws_secret_access_key $AWS_SECRET_KEY \ 
&& aws configure set default.region $AWS_REGION 

CMD ["yarn", "deploy-s3-cloudfront"]
