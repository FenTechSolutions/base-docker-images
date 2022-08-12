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
RUN apt-get -qq install r-base -y --allow-unauthenticated
RUN apt-get -qq install libssl-dev -y
RUN apt-get -qq install libgmp3-dev  -y --allow-unauthenticated
RUN apt-get -qq install git -y
RUN apt-get -qq install build-essential  -y --allow-unauthenticated
RUN apt-get -qq install libv8-dev  -y --allow-unauthenticated
RUN apt-get -qq install libcurl4-openssl-dev -y --allow-unauthenticated
RUN apt-get -qq install libopenblas-dev -y --allow-unauthenticated
RUN apt-get -qq install libgsl-dev -y
RUN Rscript -e 'install.packages("usethis",repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("V8"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("sfsmisc"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("clue"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/randomForest/randomForest_4.7-1.tar.gz", repos=NULL, type="source", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("lattice"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("devtools"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages(c("MASS"),repos="http://cran.us.r-project.org", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'install.packages("BiocManager")'
RUN Rscript -e 'BiocManager::install(c("igraph"))'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/fastICA/fastICA_1.2-3.tar.gz", repos=NULL, type="source")'
RUN Rscript -e 'BiocManager::install(c("SID", "bnlearn", "pcalg", "kpcalg", "glmnet", "mboost"))'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/CAM/CAM_1.0.tar.gz", repos=NULL, type="source")'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/sparsebnUtils_0.0.8.tar.gz", repos=NULL, type="source")'
RUN Rscript -e 'BiocManager::install(c("ccdrAlgorithm", "discretecdAlgorithm"))'

# RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/D2C/D2C_1.2.1.tar.gz", repos=NULL, type="source", quiet=TRUE, verbose=FALSE)'
RUN Rscript -e 'library(devtools); install_github("cran/momentchi2"); install_github("Diviyan-Kalainathan/RCIT")'
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/sparsebn/sparsebn_0.1.2.tar.gz", repos=NULL, type="source")'
CMD /bin/sh
