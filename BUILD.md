# Build

Generar la guía localmente con Docker (requiere internet):

```bash
docker run --rm -it --entrypoint bash --user 0:0 \
  -v "$PWD":/build -w /build \
  hl7fhir/ig-publisher-base:latest -c '
    npm install -g fsh-sushi
    bash _genonce.sh
    chown -R $(stat -c "%u:%g" .) .
  '
```

El sitio queda en `output/` → abrir `output/index.html`.

Actualizar el IG Publisher: `bash _updatePublisher.sh -y` y commitear `input-cache/publisher.jar`.
