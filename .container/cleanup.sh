#! /bin/bash
# Remove a container and its image.
# VMO LAB, 2024

container_name=advcmp
image_name=advcmp
directory_name=advcmp

docker rm -f $container_name
docker rmi $image_name
rm -rf ../$directory_name/build