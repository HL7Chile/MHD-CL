# FHIR.MHDIG\Capacidades para Cliente MHD - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Capacidades para Cliente MHD**

## CapabilityStatement: Capacidades para Cliente MHD 

| | |
| :--- | :--- |
| *Official URL*:http://mhd.ri.hsisalud.org/CapabilityStatement/MHDCliente | *Version*:0.3.0 |
| Draft as of 2026-09-02 | *Computable Name*:MHDCliente |

 
CapabilityStatement que define las capacidades requeridas para los sistemas cliente que interactúan con el MHD Responder definido por esta guía. 
El cliente implementa las funciones de Document Source y Document Consumer definidas por IHE MHD 4.2.2, adaptadas a los perfiles y restricciones de esta implementación local. 
El cliente puede publicar documentos mediante ITI-65, consultar SubmissionSets mediante ITI-66, localizar referencias documentales mediante ITI-67 y recuperar documentos mediante ITI-68. 

 [Raw OpenAPI-Swagger Definition file](MHDCliente.openapi.json) | [Download](MHDCliente.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "MHDCliente",
  "url" : "http://mhd.ri.hsisalud.org/CapabilityStatement/MHDCliente",
  "version" : "0.3.0",
  "name" : "MHDCliente",
  "title" : "Capacidades para Cliente MHD",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-09-02",
  "publisher" : "HSI Pladema",
  "contact" : [{
    "name" : "HSI Pladema",
    "telecom" : [{
      "system" : "url",
      "value" : "https://hsi.pladema.net"
    }]
  }],
  "description" : "CapabilityStatement que define las capacidades requeridas para los\nsistemas cliente que interactúan con el MHD Responder definido por\nesta guía.\n\nEl cliente implementa las funciones de Document Source y Document\nConsumer definidas por IHE MHD 4.2.2, adaptadas a los perfiles y\nrestricciones de esta implementación local.\n\nEl cliente puede publicar documentos mediante ITI-65, consultar\nSubmissionSets mediante ITI-66, localizar referencias documentales\nmediante ITI-67 y recuperar documentos mediante ITI-68.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "AR",
      "display" : "Argentina"
    }]
  }],
  "kind" : "requirements",
  "instantiates" : ["https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentSource",
  "https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentConsumer"],
  "fhirVersion" : "4.0.1",
  "format" : ["application/fhir+json", "application/fhir+xml"],
  "implementationGuide" : ["http://mhd.ri.hsisalud.org/ImplementationGuide/fhir.mhdig"],
  "rest" : [{
    "mode" : "client",
    "documentation" : "Cliente MHD local que permite publicar, localizar y recuperar\ndocumentos clínicos mediante las transacciones definidas por\nIHE MHD y los perfiles definidos por esta guía.",
    "security" : {
      "description" : "Las comunicaciones deben realizarse mediante HTTPS y utilizar\nlos mecanismos de autenticación, autorización, control de acceso,\nauditoría y trazabilidad definidos para la infraestructura local."
    },
    "resource" : [{
      "type" : "DocumentReference",
      "profile" : "http://mhd.ri.hsisalud.org/StructureDefinition/ReferenciaDocumental",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type",
        "documentation" : "ITI-67 Find Document References.\n\nEl cliente SHALL poder buscar referencias documentales utilizando\nlos parámetros definidos por IHE MHD y las restricciones establecidas\npor esta guía."
      }],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token"
      },
      {
        "name" : "_lastupdated",
        "type" : "date"
      },
      {
        "name" : "author.given",
        "type" : "string"
      },
      {
        "name" : "author.family",
        "type" : "string"
      },
      {
        "name" : "category",
        "type" : "token"
      },
      {
        "name" : "creation",
        "type" : "date"
      },
      {
        "name" : "date",
        "type" : "date"
      },
      {
        "name" : "event",
        "type" : "token"
      },
      {
        "name" : "facility",
        "type" : "token"
      },
      {
        "name" : "format",
        "type" : "token"
      },
      {
        "name" : "identifier",
        "type" : "token"
      },
      {
        "name" : "patient",
        "type" : "reference"
      },
      {
        "name" : "patient.identifier",
        "type" : "token"
      },
      {
        "name" : "period",
        "type" : "date"
      },
      {
        "name" : "related",
        "type" : "reference"
      },
      {
        "name" : "security-label",
        "type" : "token"
      },
      {
        "name" : "setting",
        "type" : "token"
      },
      {
        "name" : "status",
        "type" : "token"
      },
      {
        "name" : "type",
        "type" : "token"
      }]
    },
    {
      "type" : "List",
      "profile" : "http://mhd.ri.hsisalud.org/StructureDefinition/ListMhd",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type",
        "documentation" : "ITI-66 Find Document Lists.\n\nEl cliente SHALL poder consultar SubmissionSets representados mediante\nel recurso List y el perfil ListMhd definido por esta guía."
      }],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token"
      },
      {
        "name" : "_lastupdated",
        "type" : "date"
      },
      {
        "name" : "code",
        "type" : "token"
      },
      {
        "name" : "date",
        "type" : "date"
      },
      {
        "name" : "identifier",
        "type" : "token"
      },
      {
        "name" : "patient",
        "type" : "reference"
      },
      {
        "name" : "patient.identifier",
        "type" : "token"
      },
      {
        "name" : "source.given",
        "type" : "string"
      },
      {
        "name" : "source.family",
        "type" : "string"
      },
      {
        "name" : "status",
        "type" : "token"
      },
      {
        "name" : "designationType",
        "type" : "token"
      },
      {
        "name" : "sourceId",
        "type" : "token"
      }]
    }],
    "interaction" : [{
      "code" : "transaction",
      "documentation" : "ITI-65 Provide Document Bundle.\n\nEl cliente SHALL poder generar y enviar un Bundle transaction\nconforme al perfil BundleMhd definido por esta guía:\n\nhttp://mhd.ri.hsisalud.org/StructureDefinition/BundleMhd"
    },
    {
      "code" : "search-system",
      "documentation" : "El cliente puede realizar búsquedas a nivel de sistema conforme\na las capacidades definidas para el Document Consumer de IHE MHD."
    }]
  }]
}

```
