BASEDIR=$(pwd)

singularity \
        --quiet \
        exec \
        --ipc \
        --cleanenv \
        --pid \
        --bind \
	$BASEDIR/test.py:/DiffRL/diffrl/test.py \
	docker://ghcr.io/uomresearchit/diffrl:pytorch \
	python3 /DiffRL/diffrl/test.py

