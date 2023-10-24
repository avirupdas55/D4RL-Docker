BASEDIR=$(pwd)

docker run \
	-v \
	$BASEDIR/test.py:/test.py \
	avirupdas55/diffrl:pytorch \
	python3 /test.py
