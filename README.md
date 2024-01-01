README

# Local
docker run -it --gpus 0 --env "TASK=translation" --env "DEVICE=cuda" --env "COMPUTE_TYPE=int8" --rm benchmark-sc-hardware 


# Images

docker pull jordimash/benchmark-sc-hardware

docker run  -it --env  "DEVICE=cuda" --env "COMPUTE_TYPE=int8" --env "DEVICE_INDEX=0"  --gpus 0 -it jordimash/benchmark-sc-hardware

docker run  -it --env  "DEVICE=cuda" --env "TASK=translation" --env "COMPUTE_TYPE=int8" --env "DEVICE_INDEX=0"  --gpus 0 -it jordimash/benchmark-sc-hardware

# 
