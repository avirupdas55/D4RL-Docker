BASEDIR=$(pwd)

singularity \
        --quiet \
        exec \
        --ipc \
        --nv \
        --cleanenv \
        --pid \
        --bind \
	$BASEDIR/test.py:/DiffRL/diffrl/test.py \
	docker://avirupdas55/diffrl:pytorch \
	python3 /DiffRL/diffrl/test.py

