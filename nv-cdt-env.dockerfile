ARG BASEIMAGE
ARG VERSION
FROM $BASEIMAGE:$VERSION
MAINTAINER Diviyan Kalainathan <diviyan@lri.fr>
ENV DEBIAN_FRONTEND noninteractive
LABEL description="Docker image for the Causal Discovery Toolbox"
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt-get -qq install dialog apt-utils -y
RUN apt-get -qq install -qq software-properties-common -y
RUN  apt-get install apt-transport-https -y
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
# RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/' -y
# RUN apt-get -qq update
RUN apt-get install r-base -y --allow-unauthenticated
RUN apt-get install libssl-dev -y
RUN apt-get install libgmp3-dev  -y --allow-unauthenticated
RUN apt-get install git -y
RUN apt-get install build-essential  -y --allow-unauthenticated
RUN apt-get install libv8-dev  -y --allow-unauthenticated
RUN apt-get install libcurl4-openssl-dev -y --allow-unauthenticated
RUN apt-get install libopenblas-dev -y --allow-unauthenticated
RUN apt-get install libgsl-dev -y
RUN apt-get install libharfbuzz-dev libfribidi-dev -y --allow-unauthenticated

RUN Rscript -e 'install.packages(c("usethis"),repos="http://cran.irsn.fr", Ncpus=4)'
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
