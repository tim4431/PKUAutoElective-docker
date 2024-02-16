# PKUAutoElective-Docker

PKUAutoElective 服务器部署

Adapted from [PKUAutoElective](https://github.com/zhongxinghong/PKUAutoElective) and [PKUElective2021Spring](https://github.com/Mzhhh/PKUElective2021Spring)

## Build
```dockerfile
FROM python:3.8.18-slim

LABEL maintainer="https://github.com/tim4431"

ADD . /PKUAutoElective
WORKDIR /PKUAutoElective

RUN pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple \
    -r requirements.txt

ENTRYPOINT ["/PKUAutoElective/pkuautoelective.sh"]
```

## Installation
Docker hub: [tim44/pkuautoelective](https://hub.docker.com/repository/docker/tim44/pkuautoelective-docker)

Clone this repository
```bash
git clone https://github.com/tim4431/PKUAutoElective-docker.git
```

修改可执行文件权限
```bash
chmod +x pkuautoelective.sh
```

注意修改`docker-compose.yml`中挂载的文件夹路径

Pull and run the image
```bash
docker compose up -d
```

## Configuration
```
.
├── config
│   ├── config.p1.ini (copied from config.sample.ini)
│   ├── config.sample.ini
│   ├── overallconfig.ini (copied from overallconfig.sample.ini)
│   └── overallconfig.sample.ini
├── docker-compose.yml
├── keys
│   ├── apikey.json (copied from apikey.sample.json)
│   ├── apikey.sample.json
│   ├── wechatkey.json (copied from wechatkey.sample.json)
│   └── wechatkey.sample.json
├── logs
│   └── p1.log
├── pkuautoelective.sh
└── README.md
```

**刷课机配置文件: `config.ini`**

见 [PKUAutoElective](https://github.com/zhongxinghong/PKUAutoElective)


**全局配置文件: `overallconfig.ini`**

```yaml
[config]
is_first_stage = true # 是否是退补选第一阶段
is_server = true      # 是否部署在服务器上
recognizer = tt       # TT 识图 api
push_interval = 20    # notification each 20min
```

**TT 识图 API配置文件: `apikey.json`**

注册及配置见 [TT识图](http://www.ttshitu.com/)
```json
{
    "username": "admin",
    "password": "passwd",
    "RecognitionTypeid": "1003",
    "Timeout": "5"
}
```

**企业微信通知: `wechatkey.json`**

企业微信延迟极低，且相比其他商业api无条数限制，可自定义markdown

见 https://developer.work.weixin.qq.com/document/path/91039


## Configuration
modify `pkuautoelective.sh` to configure the behavior of the container