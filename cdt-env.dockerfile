ARG BASEIMAGE
ARG VERSION
ARG GITHUB_PAT
FROM $BASEIMAGE
MAINTAINER Diviyan Kalainathan <diviyan@lri.fr>
LABEL description="Docker image for the Causal Discovery Toolbox"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt-get -qq install dialog apt-utils -y
RUN apt-get install apt-transport-https -y
RUN apt-get install -qq software-properties-common -y
RUN apt-get -qq update
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' -y
RUN apt-get -qq update

RUN apt-get -qq install r-base -y --allow-unauthenticated
RUN apt-get -qq install libssl-dev -y
RUN apt-get -qq install libgmp3-dev  -y --allow-unauthenticated
RUN apt-get -qq install git -y
RUN apt-get -qq install build-essential  -y --allow-unauthenticated
RUN apt-get -qq install libv8-dev  -y --allow-unauthenticated
RUN apt-get -qq install libcurl4-openssl-dev -y --allow-unauthenticated
RUN apt-get -qq install libgsl-dev -y

RUN Rscript -e 'install.packages(c("V8"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("sfsmisc"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("clue"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/randomForest/randomForest_4.6-14.tar.gz", repos=NULL, type="source")'
RUN Rscript -e 'install.packages(c("lattice"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("devtools"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("MASS"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages("BiocManager")'
RUN Rscript -e 'BiocManager::install(c("igraph"))'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/fastICA/fastICA_1.2-2.tar.gz", repos=NULL, type="source")'
RUN Rscript -e 'BiocManager::install(c("SID", "bnlearn", "pcalg", "kpcalg", "glmnet", "mboost"))'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/CAM/CAM_1.0.tar.gz", repos=NULL, type="source")'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/sparsebnUtils_0.0.8.tar.gz", repos=NULL, type="source")'
RUN Rscript -e 'BiocManager::install(c("ccdrAlgorithm", "discretecdAlgorithm"))'

RUN apt-get -qq install libxml2-dev -y --allow-unauthenticated
RUN Rscript -e 'install.packages("devtools")'
RUN Rscript -e 'library(devtools); install_github("cran/CAM"); install_github("cran/momentchi2"); install_github("Diviyan-Kalainathan/RCIT", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/sparsebn/sparsebn_0.1.2.tar.gz", repos=NULL, type="source")'

CMD /bin/sh
