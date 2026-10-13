# FHIR.MHDIG\MHD Responder - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MHD Responder**

## CapabilityStatement: MHD Responder 

| | |
| :--- | :--- |
| *Official URL*:http://mhd.ri.hsisalud.org/CapabilityStatement/MHDResponder | *Version*:0.3.0 |
| Draft as of 2026-09-02 | *Computable Name*:MHDResponder |

 
CapabilityStatement que define las capacidades requeridas para un servidor MHD conforme a la Guía MHD para HSI. 
El servidor implementa las funciones de Document Recipient y Document Responder definidas por IHE MHD 4.2.2, adaptadas a los perfiles locales de esta guía. 

 [Raw OpenAPI-Swagger Definition file](MHDResponder.openapi.json) | [Download](MHDResponder.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "MHDResponder",
  "url" : "http://mhd.ri.hsisalud.org/CapabilityStatement/MHDResponder",
  "version" : "0.3.0",
  "name" : "MHDResponder",
  "title" : "MHD Responder",
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
  "description" : "CapabilityStatement que define las capacidades requeridas para un servidor\nMHD conforme a la Guía MHD para HSI.\n\nEl servidor implementa las funciones de Document Recipient y Document\nResponder definidas por IHE MHD 4.2.2, adaptadas a los perfiles locales\nde esta guía.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "AR",
      "display" : "Argentina"
    }]
  }],
  "kind" : "requirements",
  "instantiates" : ["https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentRecipient",
  "https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentResponder"],
  "fhirVersion" : "4.0.1",
  "format" : ["application/fhir+json", "application/fhir+xml"],
  "implementationGuide" : ["http://mhd.ri.hsisalud.org/ImplementationGuide/fhir.mhdig"],
  "rest" : [{
    "mode" : "server",
    "documentation" : "Servidor MHD local que permite registrar, consultar y recuperar\ndocumentos clínicos utilizando las transacciones definidas por\nIHE MHD y los perfiles definidos por esta guía.",
    "security" : {
      "description" : "Las transacciones deben realizarse mediante HTTPS y aplicar los\nmecanismos de autenticación, autorización, control de acceso,\nauditoría y trazabilidad definidos para la infraestructura."
    },
    "resource" : [{
      "type" : "DocumentReference",
      "profile" : "http://mhd.ri.hsisalud.org/StructureDefinition/ReferenciaDocumental",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type",
        "documentation" : "ITI-67 Find Document References.\nPermite localizar referencias documentales mediante los parámetros\nde búsqueda definidos por IHE MHD y esta guía."
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
        "documentation" : "ITI-66 Find Document Lists.\nPermite consultar los SubmissionSet registrados utilizando\nel perfil ListMhd."
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
      "documentation" : "ITI-65 Provide Document Bundle.\n\nEl servidor SHALL aceptar un Bundle transaction conforme al perfil\nBundleMhd:\n\nhttp://mhd.ri.hsisalud.org/StructureDefinition/BundleMhd"
    },
    {
      "code" : "search-system",
      "documentation" : "Búsqueda a nivel de sistema de acuerdo con las capacidades\ndefinidas para IHE MHD Document Responder."
    }]
  }]
}

```
