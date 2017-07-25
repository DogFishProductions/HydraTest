source ~/.profile
hydra-cli config hello-service << ANSWERS
redis
6379
15
ANSWERS
hydra-cli config list