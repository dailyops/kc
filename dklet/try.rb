#!/usr/bin/env rundklet

set_dockerfile <<~Desc
  FROM alpine
  ENV name=geek
  ENV name1=${name}-1
  CMD sh -c 'echo name=$name name1=$name1'
Desc

task do
  # 构建时指定环境变量在运行时可覆盖, 但已被引用的不会动态计算
  system <<~Desc
    echo ==runtime env
    docker run --rm #{docker_image}
    echo ==runtime env with host env set
    env name=test docker run --rm #{docker_image}
    echo ==runtime env with docker env set
    docker run --rm --env name=test #{docker_image}
  Desc
end

start_cli!
