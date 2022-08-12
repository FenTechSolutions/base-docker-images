ARG BASEIMAGE
ARG VERSION
FROM $BASEIMAGE:$VERSION
MAINTAINER Diviyan Kalainathan <diviyan@lri.fr>
ENV DEBIAN_FRONTEND noninteractive
LABEL description="Docker image for the Causal Discovery Toolbox"
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt-get -qq install dialog apt-utils -y
RUN apt-get -qq install -qq software-properties-common dirmngr -y
RUN  apt-get install apt-transport-https -y
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME')-cran40/"
RUN apt-get update
RUN apt-get install build-essential gfortran gfortran-8 libauthen-sasl-perl libblas-dev libblas3
  libdata-dump-perl libencode-locale-perl libfile-basedir-perl
  libfile-desktopentry-perl libfile-listing-perl libfile-mimeinfo-perl
  libfont-afm-perl libgfortran-8-dev libgfortran5 libhtml-form-perl
  libhtml-format-perl libhtml-parser-perl libhtml-tagset-perl
  libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-date-perl
  libhttp-message-perl libhttp-negotiate-perl libio-html-perl
  libio-socket-ssl-perl libio-stringy-perl libipc-system-simple-perl
  liblapack-dev liblapack3 liblwp-mediatypes-perl liblwp-protocol-https-perl
  libmailtools-perl libnet-dbus-perl libnet-http-perl libnet-smtp-ssl-perl
  libnet-ssleay-perl libpaper-utils libpaper1 libpcre2-16-0 libpcre2-32-0
  libpcre2-dev libpcre2-posix0 libtext-iconv-perl libtie-ixhash-perl
  libtimedate-perl libtry-tiny-perl liburi-perl libwww-perl
  libwww-robotrules-perl libx11-protocol-perl libxcb-shape0 libxcomposite1
  libxcursor1 libxi6 libxinerama1 libxml-parser-perl libxml-twig-perl
  libxml-xpathengine-perl libxrandr2 libxtst6 libxv1 libxxf86dga1
  perl-openssl-defaults r-base-core r-base-dev r-base-html r-cran-boot
  r-cran-class r-cran-cluster r-cran-codetools r-cran-foreign
  r-cran-kernsmooth r-cran-lattice r-cran-mass r-cran-matrix r-cran-mgcv
  r-cran-nlme r-cran-nnet r-cran-rpart r-cran-spatial r-cran-survival
  r-doc-html r-recommended x11-utils x11-xserver-utils xdg-utils -y --allow-unauthenticated
RUN apt-get install libssl-dev -y
RUN apt-get install libgmp3-dev  -y --allow-unauthenticated
RUN apt-get install git -y
RUN apt-get install build-essential  -y --allow-unauthenticated
RUN apt-get install libv8-dev  -y --allow-unauthenticated
RUN apt-get install libcurl4-openssl-dev -y --allow-unauthenticated
RUN apt-get install libopenblas-dev -y --allow-unauthenticated
RUN apt-get install libgsl-dev -y
RUN apt-get install libharfbuzz-dev libfribidi-dev libfontconfig1-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev -y --allow-unauthenticated

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

RUN Rscript -e 'install.packages(c("devtools"),repos="http://cran.irsn.fr", Ncpus=4)'
RUN Rscript -e 'library(devtools); install_github("cran/CAM"); install_github("cran/momentchi2"); install_github("Diviyan-Kalainathan/RCIT")'
RUN Rscript -e 'install.packages("https://cran.irsn.fr/src/contrib/Archive/sparsebn/sparsebn_0.1.2.tar.gz", repos=NULL, type="source", Ncpus=4)'

CMD /bin/sh
