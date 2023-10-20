FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

RUN apt update && apt install -y --allow-unauthenticated wget git vim build-essential libosmesa6-dev libglew-dev glibc-source unzip
ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y mpich python3-dev python3-pip patchelf

RUN python3 -m pip install pip --upgrade pip

ENV HOME /mnt/iusers01/sk01/d30237ad
ARG UID
RUN useradd -u $UID --create-home d30237ad

RUN pip3 install -U Cython==3.0.0a10
RUN git clone https://github.com/rail-berkeley/d4rl.git
WORKDIR d4rl
RUN pip3 install -e .
WORKDIR ..
RUN mkdir -p $HOME/.mujoco 
RUN wget https://www.roboti.us/download/mujoco200_linux.zip -O mujoco200.zip
RUN unzip mujoco200.zip -d $HOME/.mujoco/
RUN rm mujoco200.zip && mv $HOME/.mujoco/mujoco200_linux $HOME/.mujoco/mujoco200
COPY mjkey.txt $HOME/.mujoco/mjkey.txt
ENV LD_LIBRARY_PATH /mnt/iusers01/sk01/d30237ad/.mujoco/mujoco200/bin:${LD_LIBRARY_PATH}
RUN pip3 install gym
RUN pip3 install mujoco_py==2.0.2.8
COPY requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt

# extra command to build mujoco-py
ENV D4RL_SUPPRESS_IMPORT_ERROR=1
RUN python3 -c "import mujoco_py"
RUN python3 -c "import d4rl"
RUN echo 'set editing-mode vi' >> $HOME/.inputrc
RUN echo 'set keymap vi' >> $HOME/.inputrc

RUN echo "LD LIBRARY PATH: $LD_LIBRARY_PATH"
RUN echo "Python version: $(python --version)"

WORKDIR $HOME/diffrl