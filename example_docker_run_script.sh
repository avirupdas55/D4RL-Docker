BASEDIR=$(pwd)

docker run \
	-v \
	$BASEDIR/test.py:/DiffRL/diffrl/test.py \
	ghcr.io/uomresearchit/diffrl:pytorch \
	python3 test.py
