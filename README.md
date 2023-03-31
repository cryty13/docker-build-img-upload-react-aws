# Docker para buildar aplicacao react e subir no s3

Esse Readme vai te ajudar a criar um docker que solicita as credenciais do aws cli
para que você possa efetuar o build de uma aplicação feita em react e depois
disso subir esse build diretamente no s3 e executar um Invalidations dentro do Cloudfront.

### Deve incluir alguns comandos dentro do package.json

```shell
"client-s3-deploy": "aws s3 sync build/ s3://NOME_DO_REPOSITORIO_DO_S3",
"client-cloudfront-invalidation":
"aws cloudfront create-invalidation --distribution-id ID_CLOUDFRONT --paths '/*'",
"deploy-s3-cloudfront": "yarn build && yarn client-s3-deploy && yarn client-cloudfront-invalidation",
"imgDocker": "docker build --build-arg AWS_KEY='' --build-arg AWS_SECRET_KEY='' --build-arg AWS_REGION='' -t deploy-acesso:1.0 .",
"docker": "docker run -v $(pwd)/:/app -it deploy-acesso:1.0",
"deploy": "npm run imgDocker && npm run docker",

```

### Explicação

- client-s3-deploy: Server para efetuar o upload no s3.
- client-cloudfront-invalidation: ira criar um invalidation dentro do cloudfront.
- deploy-s3-cloudfront: ira executar o build da aplicação e depois executar o deploy e o Invalidations
- imgDocker: este comando criara a img passando como parâmetro as credências do aws cli.
- docker: executa o docker com a imagem ja criada.
- deploy: executa a criação da imagem do docker e ira executar o docker a partir da sua pasta do projeto.

Dentro do docker ele executara o comando "deploy-s3-cloudfront" que dara continuidade no processo a partir do docker.

Para executar
```shell
yarn deploy || npm deploy
```
