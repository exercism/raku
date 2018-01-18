FROM rakudo-star:latest
RUN apt-get update && \
    apt-get install -y make gcc libyaml-dev && \
    zef install YAML::Parser::LibYAML
