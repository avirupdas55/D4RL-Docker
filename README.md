## Copy of DiffRL repository.

### Setup

The mujoco-py and D4RL code repositories will need to be cloned before creating the docker container.

Cloning the D4RL repository:
`git clone https://github.com/Farama-Foundation/D4RL.git`

Cloning the mujoco-py repository, and switching to the modified 2.0.2.8 branch.
```
git clone git@github.com:UoMResearchIT/mujoco-py.git
cd mujoco-py
git switch v2.0.2.8-local_update
cd ..
```



### Docker creation instructions.

To create the docker file run the included shell script:
```
bash docker_build.sh
```
If you wish to upload the container to dockerhub then uncomment the last three lines of that
script, and replace the username with your dockerhub username.


### Running instructions.

Scripts for running the included test.py file are given. On a system which has docker use:
```
bash example_docker_run_script.sh
```
On a system with singularity use:
```
bash example_singularity_run_script.sh
```

To run the original docker image use:
```
bash example_original_docker_run_script.sh
```
