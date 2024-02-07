# Ambiente de Desenvolvimento

author: Filipe Silva	date: 07/02/2024

**IMPORTANTE LER TODA A INFORMAÇÃO!**

O ambiente de desenvolvimento é utilizado para desenvolver software sem "sujar" a máquina local. Desta maneira quando já não precisarmos do ambiente podemos só eleminar o ambiente de desenvolvimento.

**INFORMAÇÃO**: Não esqueçer que ao longo deste documento iram ser mostrados alguns ficheiros com a configuração já pre-feita. **Estes podem ser alterados** para adaptar conforme o projecto que está a ser realizado.

**NOTA**: Este ambiente de desenvolvimento foi criado automáticamente. Se não funcionar quer dizer que alguns ficheiros possam ter de ser alterados ou configurados de uma nova maneira.

<br>

# Table of Contents

- [Ambiente de Desenvolvimento](#ambiente-de-desenvolvimento)
- [Table of Contents](#table-of-contents)
- [Requesitos](#requesitos)
	- [Docker](#docker)
		- [Windows](#windows)
		- [Linux](#linux)
		- [MacOS](#macos)
	- [WSL](#wsl)
	- [Ficheiros](#ficheiros)
		- [Criação de ficheiros](#criação-de-ficheiros)
		- [.devcontainer/devcontainer.json](#devcontainerdevcontainerjson)
		- [.github/dependabot.yml](#githubdependabotyml)
		- [.scripts/initialization.sh](#scriptsinitializationsh)
- [Como Abrir Ambiente de Desenvolvimento](#como-abrir-ambiente-de-desenvolvimento)

<br>

# Requesitos

Aqui vão estar or requesitos para conseguir ter um ambiente de desenvolvimento, irá ser preciso [Docker](#docker), no caso de a máquina ser windows é preciso [WSL](#wsl) e por fim é preciso ter os [ficheiros de configuração](#ficheiros).

<br>

## Docker

Docker é ...

---

### Windows

Para instalar o docker em Windows utilizar este [link](https://www.docker.com/products/docker-desktop/) para fazer o download.

---

### Linux

Para instalar o docker em Linux seguir a [documentação](https://docs.docker.com/engine/install/ubuntu/)

---

### MacOS

Para instalar o docker em MacOS utilizar este [link](https://www.docker.com/products/docker-desktop/) para fazer o download.

---

<br>

## WSL

Windows Subsystem for Linux é só para **Windows**. Para instalar o WSL basta ir à [Microsoft Store](https://www.microsoft.com/store/productId/9P9TQF7MRM4R?ocid=pdpshare) e instalar o mesmo.


<br>

## Ficheiros
Dentro de cada directoria há vários ficheiros:

* `.devcontainer/devctonainer.json`
* `.github/dependabot.yml`
* `.scripts/initialization.sh` 

Estes ficheiro servem para conseguir iniciar o devcontainer, que por sua vez é um contentor de docker para desenvolvimento. Mais a baixo irá haver um exemplo de como é que estes ficheiros estão configurados e como funcionam.

Para conseguir usufruir desta funcionalidade é necessário ter um IDE especifico, o `VSCode`, dentro deste tem de ser instaladas as seguintes extensões:
* `ms-vscode-remote.remote-containers`
* `ms-azuretools.vscode-docker`

Para installar as mesmas só é preciso fazer `ctrl + shift + x` e colocar os nomes referidos acima na barra de pesquisa.

---

<br>

### Criação de ficheiros


Caso não tenha os ficheiros precisa de criar os mesmos. 
Seguir os seguintes passos:
* Entrar na directoria onde deseja ter o devcontainer

* Para o caso do `.devcontainer/devcontainer.json` fazer os seguintes passos:

  1. Tem de ser criado primeiro a directoria `.devcontainer`
  
  2. Entrar dentro da directoria `.devcontainer`
  
  3. Criar ficheiro `devcontainer.json` dentro da directoria `.devcontainer`
  
* O mesmo se aplica para o `.github/dependabot.yml` e para `.scripts/initialization.sh`

Depois dos ficheiros estarem criados segue-se a configuração dos mesmos.

---

<br>

### .devcontainer/devcontainer.json

Aqui iremos mostrar um exemplo de como o ficheiro `devcontainer.json` está estruturado e configurado. Para ter um devcontainer funcional basta **copiar** a configuração a baixo para o [ficheiro previamente criado](#criação-de-ficheiros), **alterar** o que for necessário e **gravar**.

**NOTA**: A primeira linha é simplesmente para indicar o caminho onde deve ser escrita a configuração. Ou seja tem de se entrar na directoria `.devcontainer` e escrever no ficheiro `devcontainer.json`. Não é necessário copiar esta linha.

```
// path .devcontainer/devcontainer.json

// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/python
{
	// Change to desired devcontainer name
	"name": "Webserver Santos",
	// You can change remoteUser to what ever you want, but be carefull with permissions.
	"remoteUser": "vscode",
    "workspaceFolder": "/workbench",
    "workspaceMount": "source=${localWorkspaceFolder}/,target=/workbench,type=bind,consistency=cached",
    "mounts": [
      "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
    ],
	// This argument is to put the devcontainer inside a docker network
	//"runArgs": [
    //	"--network=deployment_default",
	//],	
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	"image": "mcr.microsoft.com/devcontainers/python:1-3.12-bullseye",
	"features": {
		"ghcr.io/devcontainers/features/docker-in-docker:2": {
			"moby": true,
			"azureDnsAutoDetection": true,
			"installDockerBuildx": true,
			"version": "latest",
			"dockerDashComposeVersion": "v2"
		},
		"ghcr.io/devcontainers/features/git:1": {
			"ppa": true,
			"version": "os-provided"
		}
	},

	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	// "forwardPorts": [],

	// Use 'postCreateCommand' to run commands after the container is created.
	// Put the commands you want to run inside .scripts/initialization.sh
	"postCreateCommand": "bash -i .scripts/initialization.sh",

	// Configure tool-specific properties.
	"customizations": {
		"vscode": {
			"extensions": [
				"ms-python.python",
				"charliemarsh.ruff"
			],
			"settings": {
				"files.eol": "\n",
				"editor.defaultFormatter": "charliermarsh.ruff",
				"python.analysis.autoImportCompletions": true,
				"[python]": {
					"editor.formatOnSave": true,
					"editor.defaultFormatter": "charliermarsh.ruff",
					"editor.codeActionsOnSave": {
						"source.fixAll": true,
						"source.organizeImports.ruff": true
					}
				}
			}
		}
	}
	
	// Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
	// "remoteUser": "root"
}
```

---

<br>

### .github/dependabot.yml

Aqui iremos mostrar um exemplo de como o ficheiro `dependabot.yml` está estruturado e configurado. Para ter um devcontainer funcional basta **copiar** a configuração a baixo para o [ficheiro previamente criado](#criação-de-ficheiros), **alterar** o que for necessário e **gravar**.

**NOTA**: A primeira linha é simplesmente para indicar o caminho onde deve ser escrita a configuração. Ou seja tem de se entrar na directoria `.github` e escrever no ficheiro `dependabot.yml`. Não é necessário copiar esta linha.

```yaml
# path .github/dependabot.yml

# To get started with Dependabot version updates, you'll need to specify which
# package ecosystems to update and where the package manifests are located.
# Please see the documentation for more information:
# https://docs.github.com/github/administering-a-repository/configuration-options-for-dependency-updates
# https://containers.dev/guide/dependabot

version: 2
updates:
 - package-ecosystem: "devcontainers"
   directory: "/"
   schedule:
     interval: weekly

```

---

<br>

### .scripts/initialization.sh

Este ficheiro é apenas um complemento para podermos correr automáticamente certos comandos quando iniciarmos o devcontainer, como por exemplo, `pip install` para installar todos os requisitos que o projecto necessita ou configurar o git para ficar logo configurado.

Vamos então mostrar um exemplo de como o ficheiro `initialization.sh` está estruturado e configurado. Para ter um devcontainer funcional basta **copiar** a configuração a baixo para o [ficheiro previamente criado](#criação-de-ficheiros), **alterar** o que for necessário e **gravar**.

**NOTA**: A primeira linha é simplesmente para indicar o caminho onde deve ser escrita a configuração. Ou seja tem de se entrar na directoria `.scripts` e escrever no ficheiro `initialization.sh`. Não é necessário copiar esta linha.

```bash
.scripts/initialization.sh

#!/bin/bash

# Install dependencies from requirements.txt
pip3 install --user -r requirements.txt

# Change ownership of the current directory recursively
sudo chown -R vscode:vscode .

# Configure Git user information and disable SSL verification
git config --global user.name 'John Doe'
git config --global user.email 'john.doe@example.com'
git config --global http.sslVerify false

# Add gitlabserver.io to /etc/hosts
echo '192.168.1.2 gitlabserver.io' | sudo tee -a /etc/hosts
```
<br>

**NOTA**: Não esqueçer de **GRAVAR** as configurações anteriores.

<br>

# Como Abrir Ambiente de Desenvolvimento
Após ter todos os ficheiros configurados, temos de abrir o devcontainer. Para tal é necessário fazer os seguintes comandos e selecionar as seguintes opções dentro do `VSCode`:
* Pressionar `ctrl + shift + p`
* Escolher a opção `Dev Containers: Reopen in Container`
* Escolher a opção `Dev Containers: Rebuild and Reopen in Container` caso haja alteração no ficheiro `devcontainer.json`


