# syntax=docker/dockerfile:1.4.2


FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

##### Install requirements
RUN apt update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
                   apt install -y --allow-unauthenticated \
                                  wget git vim build-essential \
                                  libosmesa6-dev libglew-dev \
                                  glibc-source unzip \
                                  mpich python3-dev python3-pip patchelf

RUN python3 -m pip install pip --upgrade pip

#### set directory variables, working directory, and add the D4RL package

ENV HOME=/DiffRL
WORKDIR $HOME

ADD D4RL $HOME/D4RL
ADD mjkey.txt $HOME/mjkey.txt
ADD requirements.txt $HOME/requirements.txt

#### single script creating the docker image  
RUN <<EOF_DiffRL
pip3 install -U Cython==3.0.0a10

cd $HOME/D4RL
pip3 install -e .

cd $HOME
mkdir $HOME/.mujoco

wget -c https://www.roboti.us/download/mujoco200_linux.zip -O mujoco200.zip
unzip mujoco200.zip -d $HOME/.mujoco/
rm mujoco200.zip
mv $HOME/.mujoco/mujoco200_linux $HOME/.mujoco/mujoco200

mv $HOME/mjkey.txt $HOME/.mujoco/mjkey.txt

LD_LIBRARY_PATH=$HOME/.mujoco/mujoco200/bin:${LD_LIBRARY_PATH}

pip3 install gym
pip3 install mujoco_py==2.0.2.8
python3 -m pip install -r requirements.txt

EOF_DiffRL
### end of script

ENV LD_LIBRARY_PATH=$HOME/.mujoco/mujoco200/bin:${LD_LIBRARY_PATH}


# extra command to build mujoco-py
ENV D4RL_SUPPRESS_IMPORT_ERROR=1
RUN python3 -c "import mujoco_py"
RUN python3 -c "import d4rl"
RUN echo 'set editing-mode vi' >> $HOME/.inputrc
RUN echo 'set keymap vi' >> $HOME/.inputrc

RUN echo "LD LIBRARY PATH: $LD_LIBRARY_PATH"
RUN echo "Python version: $(python --version)"

WORKDIR $HOME/diffrl