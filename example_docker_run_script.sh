BASEDIR=$(pwd)

docker run \
	-v \
	$BASEDIR/test.py:/DiffRL/diffrl/test.py \
	docker://avirupdas55/diffrl:pytorch \
	python3 test.py
