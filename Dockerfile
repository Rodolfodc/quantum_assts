# Usa uma imagem base mais enxuta
FROM python:3.12.2

# Autor do Dockerfile
LABEL maintainer="Rodolfo Dalla Costa"

# Define variáveis de ambiente
ENV QISKIT_USER=qiskit
ENV QISKIT_DIR=/home/$QISKIT_USER

# Cria o usuário e define permissões
RUN useradd --create-home --shell /bin/bash $QISKIT_USER

# Define o diretório de trabalho
WORKDIR $QISKIT_DIR/qiskit-jupyter

# Copia os arquivos necessários
COPY requirements.txt $QISKIT_DIR

# Instala dependências do sistema e limpa pacotes desnecessários
RUN apt-get update && \
    apt-get install -y python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Atualiza pip e instala pacotes
RUN python -m pip install --no-cache-dir -r $QISKIT_DIR/requirements.txt
RUN python -m ipykernel install --user --name=qiskit --display-name "Qiskit"

# Expor a porta usada pelo Jupyter
EXPOSE 8888

# # Alternar para o usuário qiskit (não rodar como root)
# USER $QISKIT_USER

# Comando para iniciar o JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/home/qiskit/qiskit-jupyter", "--allow-root"]
