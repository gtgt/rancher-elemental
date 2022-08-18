#/bin/bash
docker build -t luet-makeiso luet-makeiso/.

docker build -t cos-derivative derivative/.
docker run -v $PWD/derivative:/cOS -v /var/run:/var/run -ti --rm --entrypoint /usr/bin/luet-makeiso luet-makeiso ./iso.yaml --image cos-derivative

#VERSION=0.8.9-24
#docker run -v $PWD/derivative:/cOS -v /var/run:/var/run -ti --rm --entrypoint /usr/bin/luet-makeiso luet-makeiso ./iso.yaml --image quay.io/costoolkit/releases-teal:cos-system-$VERSION
