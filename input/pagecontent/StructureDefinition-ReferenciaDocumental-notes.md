### Uso de `content`

`DocumentReference.content` describe la representación del documento y la forma de acceder a ella. En JSON siempre se representa como un arreglo, aunque este perfil limite su cardinalidad a exactamente una repetición (`1..1`):

```json
"content": [
  {
    "attachment": {
      "contentType": "application/fhir+json",
      "url": "https://documentos.ejemplo.org/Bundle/ips-2026-00001",
      "title": "Resumen clínico IPS"
    }
  }
]
```

La cardinalidad `1..1` implica que:

- debe existir un elemento `content`;
- no se pueden declarar dos representaciones, por ejemplo una en JSON y otra en PDF;
- debe existir exactamente un `attachment` dentro de `content`;
- la ubicación del documento debe estar en `attachment.url`.

El elemento opcional `content.format`, heredado de FHIR/MHD, puede utilizarse para declarar una estructura, plantilla o formato documental más específico que el MIME type. No debe utilizarse para describir el mecanismo de transporte X-Road ni reemplaza a `attachment.contentType`.

### Uso de `attachment`

`content.attachment` es un dato complejo de tipo `Attachment`. En este perfil actúa como descriptor técnico del documento recuperable.

#### Reglas efectivas

| Sub-elemento | Cardinalidad efectiva | Regla de uso |
| --- | ---: | --- |
| `contentType` | `1..1` MS | Fijo en `application/fhir+json`. |
| `data` | `0..0` heredado de MHD Minimal | No se permite contenido Base64 incorporado en el `DocumentReference`. |
| `url` | `1..1` MS | Ubicación desde la cual se recupera el documento. |
| `size` | `0..1` heredado | Tamaño del contenido en bytes, cuando resulte aplicable. |
| `hash` | `0..1` MS | Hash SHA-1 del contenido, codificado en Base64, según FHIR R4. |
| `title` | `0..1` MS | Nombre legible para presentar al usuario. |
| `creation` | `0..1` heredado | Fecha original de creación del contenido, si se dispone de ella. |

La prohibición de `data` y la obligación de `url` provienen del perfil padre MHD Minimal. Por lo tanto, una instancia como la siguiente **no es válida** para este perfil:

```json
"attachment": {
  "contentType": "application/fhir+json",
  "data": "eyJyZXNvdXJjZVR5cGUiOiJCdW5kbGUifQ=="
}
```

#### `attachment.contentType`

El valor `application/fhir+json` está fijado en el perfil. Esto indica que el contenido obtenido mediante la URL debe poder entregarse como JSON FHIR.

No se debe confundir:

- `type`: tipo clínico del documento, por ejemplo un resumen clínico;
- `content.format`: estructura o plantilla específica del documento;
- `attachment.contentType`: formato MIME de los bytes recuperados;
- `Content-Type` HTTP: formato que efectivamente declara la respuesta HTTP.

Si la URL devuelve directamente un PDF con `Content-Type: application/pdf`, la instancia no representa correctamente el contenido bajo la restricción actual. Para soportar PDF sería necesario modificar el perfil o definir otro perfil que permita ese MIME type.

Si el destino es un recurso FHIR, la ruta debe coincidir con el tipo real:

- un `Bundle` de tipo `document`: `Bundle/{id}`;
- un recurso `Binary`: `Binary/{id}`.

No debe utilizarse una ruta `Binary/{id}` para identificar un recurso que en realidad es un `Bundle`.

#### `attachment.url`

La URL debe identificar una ubicación desde la cual se obtenga el contenido real del documento. Además, debe ser estable para esa versión: no debe reutilizarse más adelante para devolver bytes correspondientes a otro documento o a otra versión.

FHIR R4 permite URL absolutas y relativas en `Attachment.url`. Si se usa una referencia relativa, FHIR indica que debe resolverse respecto de la URL base del servicio, de forma equivalente a una referencia a recurso.

Ejemplos:

| Valor en `attachment.url` | Interpretación |
| --- | --- |
| `https://repo.ejemplo.org/fhir/Bundle/ips-001` | URL absoluta; no requiere una base para resolverse. |
| `Bundle/ips-001` | Relativa a la base del servicio FHIR. |
| `/pba/tndXroad/santamarina/docs/ips-xxx` | Ruta relativa al origen o *root-relative*; requiere que ese origen publique o enrute esa ruta. |
| `/r1/INSTANCE/CLASS/MEMBER/SUBSYSTEM/SERVICE/docs/ips-001` | Forma de ruta compatible con una invocación REST directa a un Security Server X-Road, si se conoce su origen y se agregan los encabezados requeridos. |

Una URL relativa **no debe interpretarse respecto de la ubicación del archivo JSON ni de la página HTML de la guía**.

#### `attachment.hash`

En FHIR R4, `Attachment.hash` corresponde al SHA-1 de los bytes originales y se expresa en Base64. Es útil para detectar cambios accidentales o verificar que se obtuvo la representación esperada.

Ejemplo de cálculo:

```bash
openssl dgst -sha1 -binary documento.json | openssl base64 -A
```

El hash se calcula sobre los bytes recuperados para el MIME type declarado, no sobre una representación Base64 de esos bytes. Este hash no constituye una firma digital y no reemplaza controles de autenticidad, autorización o no repudio.

En documentos generados bajo demanda, o cuando el contenido es un `Bundle` FHIR publicado mediante las reglas específicas de MHD, `hash` y `size` pueden requerir tratamiento especial o estar ausentes.

### Uso de una referencia relativa con X-Road

#### Qué aporta X-Road

X-Road actúa como una capa segura de intercambio entre el sistema consumidor y el sistema proveedor. En una llamada REST, el servicio se codifica en la ruta de la solicitud y el consumidor se identifica mediante el encabezado obligatorio `X-Road-Client`.

La forma general de una llamada REST X-Road es:

```text
GET https://{security-server}/r1/{instance}/{member-class}/{member-code}/{subsystem}/{service-code}/{path}
X-Road-Client: {instance}/{member-class}/{consumer-member-code}/{consumer-subsystem}
Accept: application/fhir+json
```

Por ejemplo:

```http
GET /r1/AR/GOV/99999999/REPO-DOC/obtener-documento/docs/IPS-2026-00001 HTTP/1.1
Host: security-server.ejemplo.org
X-Road-Client: AR/GOV/88888888/SISTEMA-CONSUMIDOR
Accept: application/fhir+json
```

`X-Road-Client` no se almacena en `DocumentReference`. Se determina en tiempo de ejecución a partir de la identidad del sistema que recupera el documento.

#### La ruta del perfil

El perfil incluye el siguiente ejemplo:

```text
/pba/tndXroad/santamarina/docs/ips-xxx
```

Esta ruta puede utilizarse si la arquitectura define un *gateway* o proxy capaz de interpretarla. Sin embargo, esa sintaxis **no es por sí misma la forma estándar de la URL REST de X-Road**. Debe documentarse, como mínimo:

- la URL base contra la cual se resuelve;
- el Security Server o gateway que recibe la solicitud;
- la correspondencia entre la ruta y el `serviceId` X-Road;
- el método HTTP permitido, normalmente `GET`;
- quién agrega `X-Road-Client` y los demás encabezados de seguridad;
- el MIME type que debe devolver el servicio;
- la política de autorización y los códigos de error esperados.

#### Diferencia entre validez FHIR y conformidad MHD

Este punto es fundamental:

- una URL relativa puede ser válida según el tipo `Attachment` de FHIR R4;
- el validador estructural puede aceptarla en una instancia del perfil;
- pero la transacción MHD ITI-67 exige que el `Document Responder` entregue en `DocumentReference.content.attachment.url` una **URL completa** que el consumidor pueda utilizar para ejecutar ITI-68.

Por lo tanto, una ruta relativa usada como convención interna puede no cumplir estrictamente la regla transaccional de ITI-67, aunque el recurso sea estructuralmente válido.

#### Alternativa recomendada

Para conservar la interoperabilidad MHD y utilizar X-Road, se recomienda que el `DocumentReference` entregado al consumidor contenga una URL absoluta de un endpoint recuperable:

```json
"url": "https://gateway-documental.ejemplo.org/pba/tndXroad/santamarina/docs/ips-xxx"
```

El gateway puede traducir internamente esa solicitud a X-Road, construir la ruta `/r1/{serviceId}/{path}` y agregar los encabezados que correspondan.

También puede publicarse una URL absoluta directa al Security Server:

```json
"url": "https://security-server.ejemplo.org/r1/AR/GOV/99999999/REPO-DOC/obtener-documento/docs/IPS-2026-00001"
```

En este segundo caso, el cliente debe poder comunicarse con ese Security Server y enviar `X-Road-Client`.

Si por una decisión de arquitectura se mantiene una referencia relativa, la guía debe declarar expresamente una regla de resolución, por ejemplo:

```text
baseXRoad = https://security-server.ejemplo.org
attachment.url = /r1/AR/GOV/99999999/REPO-DOC/obtener-documento/docs/IPS-2026-00001
URL efectiva = baseXRoad + attachment.url
```

Esta regla debe considerarse una convención de la guía o del ecosistema, porque la base X-Road no puede deducirse únicamente desde el `DocumentReference`.

### 7. Flujo de recuperación del documento

1. El consumidor obtiene el `DocumentReference`, por ejemplo mediante ITI-67.
2. Verifica que el recurso declara el perfil `ReferenciaDocumental`.
3. Lee `content[0].attachment.contentType` y `content[0].attachment.url`.
4. Si la URL es absoluta, la utiliza directamente.
5. Si es relativa, aplica la regla de resolución publicada por la guía o por el despliegue.
6. Si el destino usa X-Road, agrega `X-Road-Client` y los controles de autenticación requeridos.
7. Ejecuta un `GET` con `Accept: application/fhir+json`.
8. Verifica el código HTTP y el `Content-Type` de la respuesta.
9. Si existen `hash` y `size`, verifica que correspondan al contenido recuperado.
10. Procesa y valida el recurso FHIR retornado, por ejemplo un `Bundle` de tipo `document` que cumpla el perfil IPS esperado.

Conforme a ITI-68, una recuperación exitosa devuelve HTTP `200`. Entre las respuestas posibles se encuentran `404` para una ubicación desconocida, `410` para un documento ya no disponible, `406` si no se puede entregar el formato solicitado y `403` cuando la solicitud no está permitida.

### 8. Ejemplo completo en JSON

El siguiente ejemplo usa una URL absoluta de gateway, que es la alternativa recomendada para mantener una ubicación directamente resoluble:

```json
{
  "resourceType": "DocumentReference",
  "id": "referencia-ips-2026-00001",
  "meta": {
    "profile": [
      "{{canonical-guia}}/StructureDefinition/ReferenciaDocumental"
    ]
  },
  "masterIdentifier": {
    "system": "https://repositorio.salud.gob.ar/documentos/ips",
    "value": "IPS-2026-00001"
  },
  "status": "current",
  "type": {
    "coding": [
      {
        "system": "http://loinc.org",
        "code": "34133-9",
        "display": "Summary of episode note"
      }
    ]
  },
  "category": [
    {
      "coding": [
        {
          "system": "http://loinc.org",
          "code": "60591-5",
          "display": "Patient summary Document"
        }
      ],
      "text": "Resumen clínico de paciente"
    }
  ],
  "subject": {
    "reference": "Patient/paciente-123"
  },
  "date": "2026-08-24T10:00:00-03:00",
  "author": [
    {
      "reference": "Practitioner/profesional-123"
    }
  ],
  "content": [
    {
      "attachment": {
        "contentType": "application/fhir+json",
        "url": "https://gateway-documental.ejemplo.org/pba/tndXroad/santamarina/docs/ips-2026-00001",
        "title": "IPS-2026-00001"
      }
    }
  ],
  "context": {
    "period": {
      "start": "2026-08-20T08:00:00-03:00",
      "end": "2026-08-20T18:00:00-03:00"
    }
  }
}
```

### Ejemplo de instancia FSH con ruta relativa

Este ejemplo representa la convención de proxy incluida en el perfil. Solo debe utilizarse si la guía define formalmente su base y mecanismo de resolución:

```fsh
Instance: ReferenciaDocumentalXRoadEjemplo
InstanceOf: ReferenciaDocumental
Usage: #example
Title: "Referencia documental recuperable mediante X-Road"

* id = "referencia-documental-xroad-ejemplo"
* meta.profile = Canonical(ReferenciaDocumental)
* status = #current

* masterIdentifier.system = "https://repositorio.salud.gob.ar/documentos/ips"
* masterIdentifier.value = "IPS-2026-00001"

* type.coding.system = "http://loinc.org"
* type.coding.code = #34133-9
* type.coding.display = "Summary of episode note"

* category.coding.system = "http://loinc.org"
* category.coding.code = #60591-5
* category.coding.display = "Patient summary Document"
* category.text = "Resumen clínico de paciente"

* subject = Reference(Patient/paciente-123)
* date = "2026-08-24T10:00:00-03:00"
* author = Reference(Practitioner/profesional-123)

* content.attachment.contentType = #application/fhir+json
* content.attachment.url = "/pba/tndXroad/santamarina/docs/ips-xxx"
* content.attachment.title = "IPS-2026-00001"

* context.period.start = "2026-08-20T08:00:00-03:00"
* context.period.end = "2026-08-20T18:00:00-03:00"
```

### Recomendaciones de seguridad

- No incorporar tokens, contraseñas ni credenciales en `attachment.url`.
- Evitar URL firmadas de corta duración como identificador documental permanente.
- No incluir datos clínicos o identificadores personales innecesarios en la ruta.
- Aplicar listas de destinos y esquemas permitidos antes de resolver una URL para reducir riesgos SSRF.
- Autorizar la recuperación en el momento del `GET`; poder descubrir un `DocumentReference` no implica estar autorizado para obtener su contenido.
- Mantener la URL asociada a una versión inmutable del documento.
- Utilizar HTTPS y los controles de identidad, firma y auditoría definidos para X-Road.
- Usar `securityLabel` cuando el dominio de intercambio requiera comunicar sensibilidad o restricciones de manejo.
- Utilizar mecanismos de firma, por ejemplo `Provenance.signature`, cuando se necesite autenticidad o no repudio; `attachment.hash` solo comprueba integridad técnica.

### Lista de verificación

- [ ] La instancia declara el canonical correcto de `ReferenciaDocumental` en `meta.profile`.
- [ ] `masterIdentifier` es único, estable y específico de la versión documental.
- [ ] `status`, `type`, `category`, `subject`, `date` y al menos un `author` están presentes.
- [ ] El paciente cumple el perfil `PacienteArg`.
- [ ] Existe exactamente un `content` y un `attachment`.
- [ ] No se utiliza `attachment.data`.
- [ ] `attachment.contentType` es `application/fhir+json`.
- [ ] `attachment.url` permite recuperar el contenido real mediante `GET`.
- [ ] La URL no se reutiliza para entregar otra versión del documento.
- [ ] Si se usa una URL relativa, la guía define explícitamente su base de resolución.
- [ ] Si el recurso se entrega mediante ITI-67, se evalúa la exigencia MHD de utilizar una URL completa.
- [ ] Si se usa X-Road, están definidos el Security Server, `serviceId`, ruta, `X-Road-Client`, autorización y MIME type de respuesta.
- [ ] Si se informa `hash`, se calculó como SHA-1 sobre los bytes correctos y se codificó en Base64.
- [ ] El contenido recuperado se valida contra el perfil FHIR que corresponda, por ejemplo un perfil IPS de `Bundle` tipo `document`.

