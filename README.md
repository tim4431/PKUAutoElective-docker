# PKUAutoElective-Docker

PKUAutoElective 服务器容器部署

Adapted from [PKUAutoElective](https://github.com/zhongxinghong/PKUAutoElective) and [PKUElective2022Spring](https://github.com/Totoro-Li/PKUElective2022Spring)

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
docker compose up
```

## Configuration
```
.
├── config
│   ├── config.p1.ini (copied from config.sample.ini)
│   ├── overallconfig.ini (copied from overallconfig.sample.ini)
├── docker-compose.yml
├── keys
│   ├── apikey.json (copied from apikey.sample.json)
│   ├── mailkey.json (copied from mailkey.sample.json)
│   └── wechatkey.json (copied from wechatkey.sample.json)
├── logs
│   └── p1.log
├── pkuautoelective.sh
└── README.md
```

**刷课机配置文件: `config.p1.ini`**

这里 `p1` 代表 page 1, 名称自定义, 可同时添加多个配置文件

具体定义方式见 [PKUAutoElective](https://github.com/zhongxinghong/PKUAutoElective)

在 `config.p1.ini` 中添加下列配置，用于配置提醒服务
```yaml
[prompter]

wechat_prompt = true # 是否开启企业微信推送
mail_prompt = true   # 是否开启邮件推送
sound_prompt = true  # 在个人电脑运行时，是否开启声音提醒
```

**全局配置文件: `overallconfig.ini`**

```yaml
[config]
is_first_stage = true # 是否是退补选第一阶段
is_server = true      # 是否部署在服务器上，如果是则不会开启声音提醒
recognizer = tt       # TT 识图 api
push_interval = 20    # scheduled notification each 20min
```

**TT 识图 API配置文件: `apikey.json`**

注册及配置见 [TT识图](http://www.ttshitu.com/)
```json
{
    "username": "admin",
    "password": "passwd",
    "RecognitionTypeid": "1003",
    "RecognitionWeights": {"3":0.4, "1003":0.7, "7":1.0},
    "Timeout": "5"
}
```

**qq邮箱通知: `mailkey.json`**
```json
{
    "mail_host": "smtp.qq.com",
    "mail_user": "xxxxxx@qq.com",
    "mail_pass": "passwd",
    "sender": "xxxxxx@qq.com",
    "receivers": ["xxxxxx@qq.com"]
}
```
其中 `mail_pass` 并不是邮箱登录密码而是 `smtp` 服务密钥

**企业微信通知: `wechatkey.json`**

企业微信延迟极低，且相比其他商业api无条数限制，可自定义markdown

见 https://developer.work.weixin.qq.com/document/path/91039


## Configuration

修改 `pkuautoelective.sh` 来自定义docker运行方式
```bash
#!/bin/bash
NOW=$(date +"%Y-%m-%d_%H-%M-%S")

echo p1 start
nohup python main.py -c ./PAE_private/config/config.p1.ini -m > ./logs/${NOW}_p1.log 2>&1 &

tail -f ./logs/${NOW}_p1.log
```

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=tim4431/PKUAutoElective-docker&type=Date)](https://star-history.com/#tim4431/PKUAutoElective-docker&Date)
