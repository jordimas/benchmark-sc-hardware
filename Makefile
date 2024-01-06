docker-build:
	docker build --build-arg HF_TOKEN=${HF_TOKEN} -t benchmark-sc-hardware . -f Dockerfile;
	docker image ls | grep benchmark-sc-hardware
	
docker-run:
	docker run -it --rm benchmark-sc-hardware  --gpus 0;

docker-publish:
	docker tag benchmark-sc-hardware jordimash/benchmark-sc-hardware:latest
	docker push jordimash/benchmark-sc-hardware:latest


