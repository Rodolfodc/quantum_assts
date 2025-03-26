wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ~/Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda create --name qiskit
conda activate qiskit
conda install pip
pip instal -r requirements.txt
python -m ipykernel install --user --name=qiskit --display-name "Qiskit"