# FHIR.MHDIG\Transacciones asociadas a MHD - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* **Transacciones asociadas a MHD**

## Transacciones asociadas a MHD

# Transacciones MHD

Esta página describe las transacciones utilizadas para registrar, buscar y recuperar documentos clínicos mediante **IHE Mobile access to Health Documents (MHD)** sobre **HL7 FHIR R4**.

La implementación utiliza los perfiles de **IHE MHD** para el intercambio documental y los perfiles de **Core AR** para representar las entidades nacionales, como pacientes, profesionales y organizaciones.

## Contenido

* [Actores MHD](#actores-mhd)
* [Transacción 1: Registrar un documento — ITI-65](#transacción-1-registrar-un-documento--iti-65)
* [Transacción 2: Buscar documentos — ITI-67](#transacción-2-buscar-documentos--iti-67)
* [Transacción 3: Recuperar un documento — ITI-68](#transacción-3-recuperar-un-documento--iti-68)
* [Códigos de respuesta HTTP](#códigos-de-respuesta-http)
* [Seguridad](#seguridad)

-------

## Actores MHD

| | |
| :--- | :--- |
| **Document Source** | Genera y envía documentos clínicos con sus metadatos. |
| **Document Recipient** | Recibe, valida y registra los documentos enviados. |
| **Document Consumer** | Busca referencias documentales y solicita los documentos. |
| **Document Responder** | Responde las búsquedas y entrega los documentos solicitados. |

-------

## Transacción 1: Registrar un documento — ITI-65

**Nombre IHE:** Provide Document Bundle
 **Actores:** Document Source → Document Recipient
 **Método HTTP:** `POST [base]`

### Descripción

La transacción **ITI-65** permite enviar documentos clínicos y sus metadatos al receptor documental. La solicitud se representa mediante un `Bundle` FHIR de tipo `transaction`, que debe procesarse de manera atómica: todas las entradas se procesan correctamente o la transacción completa es rechazada.

### Recursos de la transacción

| | |
| :--- | :--- |
| `Bundle`de tipo`transaction` | Contenedor de la transacción. |
| `List`tipo SubmissionSet | Agrupa los documentos pertenecientes a una misma presentación. |
| Uno o más`DocumentReference` | Contienen los metadatos y la referencia al contenido documental. |
| `Binary`o`Bundle`tipo`document` | Representan el documento, según la opción MHD implementada. |
| `Patient`basado en Core AR | Identifica al paciente cuando debe incluirse o registrarse en la misma transacción. |
| Otros recursos Core AR | Representan profesionales u organizaciones cuando corresponda. |

> La guía local debe declarar expresamente si el contenido se envía como `Binary`, como un `Bundle` FHIR de tipo `document` o se mantiene en un repositorio externo mediante la opción de referencias no contenidas.

### Solicitud

```
POST [base]
Content-Type: application/fhir+json
Accept: application/fhir+json

```

```
{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    {
      "fullUrl": "urn:uuid:submission-set",
      "resource": {
        "resourceType": "List",
        "status": "current",
        "mode": "working"
      },
      "request": {
        "method": "POST",
        "url": "List"
      }
    },
    {
      "fullUrl": "urn:uuid:document-reference",
      "resource": {
        "resourceType": "DocumentReference",
        "status": "current"
      },
      "request": {
        "method": "POST",
        "url": "DocumentReference"
      }
    },
    {
      "fullUrl": "urn:uuid:clinical-document",
      "resource": {
        "resourceType": "Bundle",
        "type": "document"
      },
      "request": {
        "method": "POST",
        "url": "Bundle"
      }
    }
  ]
}

```

### Diagrama de secuencia

### Respuesta exitosa

El éxito de la transacción se informa mediante un estado HTTP general `200 OK`. Cada entrada del `Bundle` de respuesta indica el resultado individual de su operación, normalmente `201 Created` para los recursos creados.

```
{
  "resourceType": "Bundle",
  "type": "transaction-response",
  "entry": [
    {
      "response": {
        "status": "201 Created",
        "location": "List/123/_history/1"
      }
    },
    {
      "response": {
        "status": "201 Created",
        "location": "DocumentReference/456/_history/1"
      }
    },
    {
      "response": {
        "status": "201 Created",
        "location": "Bundle/789/_history/1"
      }
    }
  ]
}

```

-------

## Transacción 2: Buscar documentos — ITI-67

La transacción **ITI-67 Find Document References** permite al **Document Consumer** buscar referencias documentales en el **Document Responder** mediante el recurso `DocumentReference`.

El servidor **DEBE soportar los parámetros de búsqueda obligatorios definidos por IHE MHD para ITI-67**. La presente guía puede además establecer restricciones, combinaciones recomendadas o parámetros adicionales para responder a las necesidades de la implementación local.

Entre los parámetros utilizados se incluyen, entre otros: `patient`, `patient.identifier`, `status`, `type`, `category`, `date`, `creation`, `identifier`, `format`, `facility`, `event`, `security-label` y los parámetros de identificación del autor.

Los parámetros y requisitos detallados que debe soportar el servidor se especifican formalmente en el **CapabilityStatement MHD Responder** de esta guía.

### Solicitud por identificador del paciente

```
GET [base]/DocumentReference?patient.identifier=[system]|[value]&status=current
Accept: application/fhir+json

```

Ejemplo:

```
GET [base]/DocumentReference?patient.identifier=http://www.renaper.gob.ar/dni|25486731&status=current

```

### Diagrama de secuencia

### Respuesta exitosa

La respuesta será `200 OK`, incluso cuando no se encuentren documentos. En ese caso, el `Bundle.total` será `0` y no contendrá entradas de resultados.

```
{
  "resourceType": "Bundle",
  "type": "searchset",
  "total": 1,
  "entry": [
    {
      "fullUrl": "https://servidor.example.org/fhir/DocumentReference/456",
      "resource": {
        "resourceType": "DocumentReference",
        "id": "456",
        "status": "current",
        "subject": {
          "reference": "Patient/123"
        },
        "content": [
          {
            "attachment": {
              "contentType": "application/fhir+json",
              "url": "https://servidor.example.org/fhir/Bundle/789",
              "title": "Documento clínico"
            }
          }
        ]
      },
      "search": {
        "mode": "match"
      }
    }
  ]
}

```

-------

## Transacción 3: Recuperar un documento — ITI-68

**Nombre IHE:** Retrieve Document
 **Actores:** Document Consumer → Document Responder
 **Método HTTP:** `GET [URL del documento]`

### Descripción

La transacción **ITI-68** permite recuperar el documento previamente localizado mediante ITI-67. El consumidor debe utilizar la dirección indicada en `DocumentReference.content.attachment.url`.

Cuando el documento se representa como un `Bundle` FHIR de tipo `document`, la dirección puede corresponder a un endpoint como:

```
GET [base]/Bundle/[id]

```

Si el documento se almacena como `Binary` o en un repositorio documental externo, se utiliza directamente la URL informada en el `DocumentReference`.

### Encabezados

El consumidor puede utilizar el encabezado `Accept` para indicar el formato requerido:

```
GET [DocumentReference.content.attachment.url]
Accept: application/fhir+json

```

El formato solicitado debe ser compatible con el tipo informado en `DocumentReference.content.attachment.contentType`.

### Diagrama de secuencia

### Respuesta exitosa: documento FHIR

```
{
  "resourceType": "Bundle",
  "id": "789",
  "type": "document",
  "timestamp": "2026-08-17T10:30:00-03:00",
  "entry": [
    {
      "resource": {
        "resourceType": "Composition",
        "id": "composition-1",
        "status": "final"
      }
    },
    {
      "resource": {
        "resourceType": "Patient",
        "id": "patient-1"
      }
    }
  ]
}

```

-------

## Códigos de respuesta HTTP

| | | |
| :--- | :--- | :--- |
| `200 OK` | Operación exitosa | Transacción procesada, búsqueda ejecutada o documento recuperado correctamente. |
| `201 Created` | Recurso creado | Se utiliza en las respuestas individuales de las entradas de una transacción exitosa. |
| `400 Bad Request` | Solicitud incorrecta | La sintaxis, los parámetros o la estructura de la solicitud son inválidos. |
| `401 Unauthorized` | Sin autenticación | No se presentaron credenciales válidas. |
| `403 Forbidden` | Sin autorización | La identidad autenticada no tiene permisos para realizar la operación. |
| `404 Not Found` | Recurso inexistente | La referencia o el documento solicitado no existe o no puede ser revelado. |
| `409 Conflict` | Conflicto | Existe una colisión de identificadores, versiones o reglas de negocio. |
| `422 Unprocessable Entity` | Error de validación | El contenido puede procesarse, pero no cumple los perfiles o restricciones FHIR. |
| `500 Internal Server Error` | Error interno | El servidor no pudo completar la operación. |

Cuando se produce un error, el servidor debería entregar un recurso `OperationOutcome` con información suficiente para identificar la causa.

```
{
  "resourceType": "OperationOutcome",
  "issue": [
    {
      "severity": "error",
      "code": "invalid",
      "diagnostics": "El recurso no cumple con el perfil declarado."
    }
  ]
}

```

-------

## Seguridad

Las transacciones deben ejecutarse mediante HTTPS y aplicar los mecanismos de autenticación, autorización, control de acceso y auditoría definidos por la infraestructura nacional o institucional.

Como mínimo, la implementación debe considerar:

* autenticación del sistema solicitante;
* autorización según operación y paciente;
* protección de la confidencialidad e integridad de los documentos;
* registro de auditoría de las operaciones;
* trazabilidad de accesos y recuperaciones;
* cumplimiento de las políticas de consentimiento aplicables.

## Referencias

* [IHE MHD — Provide Document Bundle ITI-65](https://profiles.ihe.net/ITI/MHD/ITI-65.html)
* [IHE MHD — Find Document References ITI-67](https://profiles.ihe.net/ITI/MHD/ITI-67.html)
* [IHE MHD — Retrieve Document ITI-68](https://profiles.ihe.net/ITI/MHD/ITI-68.html)
* [HL7 FHIR R4](https://hl7.org/fhir/R4/)

