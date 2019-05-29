FROM jupyter/all-spark-notebook

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"
# Modified by David Guardia for Data Science development

USER root

COPY ./config/odbcinst.ini /etc/odbcinst.ini
COPY ./config/fonts /usr/share/fonts/truetype/
COPY ./config/matplotlibrc /home/$NB_USER/.config/matplotlib/

RUN apt-get update && \
    apt-get -qy install --reinstall apt-utils && \
    apt-get -qy install --reinstall build-essential && \
    apt-get -qy install gcc\
                freetds-dev \
                freetds-bin \
                unixodbc-dev \
                tdsodbc \
                default-jdk \
                xvfb

RUN update-alternatives --config java && \
    chown $NB_UID:users /home/$NB_USER -R  && \
    chmod 755 /home/$NB_USER -R  && \
    odbcinst -q -d -i -f /etc/odbcinst.ini

USER $NB_UID

RUN pip install --upgrade setuptools && \
    pip install --upgrade pip

COPY ./config/requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

RUN conda install --quiet --yes -c \
    'conda-forge' \
    'conda-build' \
    'blas=*=openblas' \
    'cloudpickle' \
    'cython' \
    'dask' \
    'dill' \
    'h5py' \
    'hdf5' \
    'ipywidgets' \
    'jpype1' \
    'jupyter_contrib_nbextensions' \
    'numexpr' \
    'osmnx' \
    'pandas' \
    'patsy' \
    'protobuf' \
    'pymongo' \
    'spacy' \
    'matplotlib' \
    'scipy' \
    'scikit-learn' \
    'scikit-image' \
    'sympy' \
    'statsmodels' \
    'sqlalchemy' \
    'vincent' \
    'xlrd'  && \
    conda remove --quiet --yes --force qt pyqt && \
    conda clean -tipsy && \
    # Activate ipywidgets extension in the environment that runs the notebook server
    jupyter contrib nbextension install --user && \
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp

RUN conda build purge-all


# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER

# ENV DISPLAY=:0

USER root
RUN python -m nltk.downloader -d /usr/share/nltk_data vader_lexicon \
                                                      stopwords \
                                                      maxent_ne_chunker \
                                                      maxent_treebank_pos_tagger \
                                                      words \
                                                      punkt \
                                                      averaged_perceptron_tagger

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    fc-cache && \
    fc-list


USER $NB_UID
RUN rm -rf /home/$NB_USER/work



VOLUME /notebooks
WORKDIR /notebooks

# CMD is required by Heroku
CMD /opt/conda/bin/jupyter notebook --port=8888 --no-browser --allow-root --NotebookApp.token='demo'