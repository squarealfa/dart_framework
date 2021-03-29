#!/bin/bash

paths=(
'./generators_common'
'./proto_mapper/proto_annotations/ '
'./proto_mapper/proto_generator/ '
'./proto_mapper/proto_mapper_example/ '
'./proto_mapper/test/ '
'./map_mapper/map_mapper_annotations'
'./map_mapper/map_mapper_generator'
'./map_mapper/map_mapper_example'
'./map_mapper/test'
'./defaults_provider/defaults_provider_annotations'
'./defaults_provider/defaults_provider_generator'
'./defaults_provider/defaults_provider_example'
'./defaults_provider/test'
'./entity/entity_annotations'
'./entity/entity_generator'
'./entity/example'
'./entity/test'
'./entity_adapter/entity_adapter'
'./entity_adapter/entity_adapter_generator'
'./entity_adapter/example'
'./example_model'
'./arango_driver'
'./security'
'./nosql_repository'
'./arango_repository'
)


if [ -z $1 ]
then
    arg=""
else
    arg=$1
fi

if [ "$arg" != "upgrade" ]
then
    echo "To perform an upgrade of all dependencies, run 'update-deps.sh upgrade'"
fi

function update()
{
    if [ "$2" = "upgrade" ]
    then
        echo "** Upgrading $1"
        dart pub upgrade
    else
        echo "** Getting dependencies for $1"
        dart pub get
    fi
}

for p in "${paths[@]}"
do
    echo $p

    (cd $p; update $p $arg )
done


