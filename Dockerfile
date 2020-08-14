FROM alpine as py36

RUN  mkdir -p /opt/codes/

#WORKDIR /Users/haben/Documents/GitHub/python-ismrmrd-server/


RUN     apk --no-cache add hdf5 hdf5-dev --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
     && apk --no-cache add cmake build-base boost-dev boost-static libxml2-dev libxslt-dev git fftw-dev
     


RUN  cd /opt/codes \
     && git clone https://github.com/NUcvmri/python-ismrmrd-server.git

COPY  new_eddy /opt/codes/python-ismrmrd-server/new_eddy
COPY  new_noise /opt/codes/python-ismrmrd-server/new_noise
COPY  pre-trained /opt/codes/python-ismrmrd-server/pre-trained
COPY  alis_og_t /opt/codes/python-ismrmrd-server/alis_og_t
COPY  alis_og_x /opt/codes/python-ismrmrd-server/alis_og_x

RUN  cd /opt/codes/python-ismrmrd-server

FROM tensorflow/tensorflow:1.14.0-py3

COPY --from=py36 /opt/codes/python-ismrmrd-server /opt/codes/python-ismrmrd-server

#WORKDIR /Users/haben/Documents/GitHub/python-ismrmrd-server/

#COPY  new_eddy/ /opt/codes/python-ismrmrd-server/new_eddy/

RUN  pip install --upgrade pip
RUN  pip install pyxb --no-cache-dir
RUN  pip install ismrmrd
RUN  pip install tensorflow==1.12.0


#RUN pip install --no-cache-dir -r /opt/codes/python-ismrmrd-server/requirements.txt

RUN pip install numpy==1.16.4
RUN pip install scikit-image==0.15.0

RUN pip install scipy==1.4.1

#RUN  apk del gcc git
RUN cd /opt/codes/python-ismrmrd-server

CMD [ "python", "/opt/codes/python-ismrmrd-server/main.py", "-l=/tmp/python-ismrmrd-server.log"]

# RUN pip install numpy==1.16.6
#CMD ["python"]
