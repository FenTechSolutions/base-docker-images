ARG BASEIMAGE
ARG VERSION
ARG GITHUB_PAT
FROM $BASEIMAGE
MAINTAINER Diviyan Kalainathan <diviyan@lri.fr>
LABEL description="Docker image for the Causal Discovery Toolbox"
ENV DEBIAN_FRONTEND noninteractive
RUN sudo apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive sudo apt-get install -y tzdata
RUN sudo apt-get -qq install dialog apt-utils -y
RUN sudo apt-get install apt-transport-https -y
RUN sudo apt-get install libseccomp-dev seccomp -y
RUN sudo apt-get install software-properties-common dirmngr -y
RUN sudo apt-get update
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
# RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/debian $(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME')-cran40/" -y
RUN sudo apt-get  update


RUN sudo apt-get install -t buster-cran40 r-base -y --allow-unauthenticated
RUN sudo apt-get install libssl-dev -y
RUN sudo apt-get install libgmp3-dev  -y --allow-unauthenticated
RUN sudo apt-get install git -y
RUN sudo apt-get install build-essential  -y --allow-unauthenticated
RUN sudo apt-get install libv8-dev  -y --allow-unauthenticated
RUN sudo apt-get install libcurl4-openssl-dev -y --allow-unauthenticated
RUN sudo apt-get install libgsl-dev -y
RUN sudo apt-get install libxml2-dev -y --allow-unauthenticated
RUN sudo apt-get install libharfbuzz-dev libfribidi-dev libfontconfig1-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev -y --allow-unauthenticated

RUN sudo chmod -R 777 /usr/local/lib/R/
RUN Rscript -e 'install.packages(c("usethis", "shiny"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages(c("Rcpp"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages(c("V8"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages(c("sfsmisc"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages(c("clue"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages("https://cran.irsn.fr/src/contrib/Archive/randomForest/randomForest_4.6-14.tar.gz", repos=NULL, type="source", Ncpus=4)'
RUN Rscript -e 'install.packages(c("lattice"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages(c("devtools"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages(c("MASS"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'install.packages("BiocManager", Ncpus=4)'
RUN Rscript -e 'BiocManager::install(c("igraph"), Ncpus=4)'
RUN Rscript -e 'install.packages("https://cran.irsn.fr/src/contrib/Archive/fastICA/fastICA_1.2-2.tar.gz", repos=NULL, type="source", Ncpus=4)'
RUN Rscript -e 'BiocManager::install(c("SID", "bnlearn", "pcalg", "kpcalg", "glmnet", "mboost"), Ncpus=4)'
RUN Rscript -e 'install.packages("https://cran.irsn.fr/src/contrib/Archive/CAM/CAM_1.0.tar.gz", repos=NULL, type="source", Ncpus=4)'
RUN Rscript -e 'install.packages("https://cran.irsn.fr/src/contrib/sparsebnUtils_0.0.8.tar.gz", repos=NULL, type="source", Ncpus=4)'
RUN Rscript -e 'BiocManager::install(c("ccdrAlgorithm", "discretecdAlgorithm"), Ncpus=4)'

RUN Rscript -e 'library(devtools); install_github("cran/CAM"); install_github("cran/momentchi2"); install_github("Diviyan-Kalainathan/RCIT")'
RUN Rscript -e 'install.packages("https://cran.irsn.fr/src/contrib/Archive/sparsebn/sparsebn_0.1.2.tar.gz", repos=NULL, type="source", Ncpus=4)'

CMD /bin/sh
